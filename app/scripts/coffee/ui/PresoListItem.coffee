class PresoListItem extends joControl
  constructor: (@object) ->
    @title = @object.title
    @titleLabel = new joLabel(@title)
    @numSlides = @object.slides.length
    @startButton = new joButton("Start")
    @editButton = new joButton("Edit")
    @deleteButton = new joButton("Delete")
    @manageExpando = new ManageExpando(@object)
    
    @onSelect()
    
  getView: () ->
    @container = new joFlexrow()
    #container.push(new joImage())
    @container.push(new joLabel(@title))
    @container.push(new joLabel(@numSlides + " slides"))
    @container.push(@startButton)
    @container.push(@manageExpando.getView())
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
    #@editButton.selectEvent.subscribe(() ->
    #   open preso in editor window
      #preso = new Presentation()
      #console.log(self.object)
      #preso.loadPresentation(self.object)
      #slideText = ""
      #slideText += slide.toString() for slide in preso.slides
      #window.e = new CodeEditor(preso)
      #window.e.setValue(slideText.replace(/<br\/>/g,""))
    #)
    #@deleteButton.selectEvent.subscribe(() ->
    #  app.screen.alert("Deleted Presentation.")
      #key = self.object.title.toLowerCase()
      #app.db.remove(key, ()->
    #     TODO Refresh display
        #app.screen.alert("Removed "+self.object.title)
        #
      #)
    #)
    
  toString: () ->
    @title
    
window.PresoListItem = PresoListItem