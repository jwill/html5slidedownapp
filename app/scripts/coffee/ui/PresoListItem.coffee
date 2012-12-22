class PresoListItem extends joControl
  constructor: (@object) ->
    @title = @object.title
    @titleLabel = new joLabel(@title)
    @startButton = new joButton("Start")
    @editButton = new joButton("Edit")
    
    @onSelect()
    
  getView: () ->
    @container = new joFlexrow()
    #container.push(new joImage())
    @container.push(new joLabel(@title))
    @container.push(new joLabel("Num slides"))
    @container.push(@startButton)
    @container.push(@editButton)
    @container
    
  onSelect: () ->
    self = this
    @startButton.selectEvent.subscribe(() ->
        joLog("hit start on", self.title)
        preso = new Presentation()
        console.log(self.object)
        preso.loadPresentation(self.object)
        preso.showPresentation()
    )
    @editButton.selectEvent.subscribe(() ->
      # open preso in editor window
      preso = new Presentation()
      console.log(self.object)
      preso.loadPresentation(self.object)
      slideText = ""
      slideText += slide.toString() for slide in preso.slides
      window.e = new CodeEditor(preso)
      window.e.setValue(slideText.replace(/<br\/>/g,""))
    )
    
  toString: () ->
    @title
    
window.PresoListItem = PresoListItem