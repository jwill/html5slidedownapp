class PresoListItem extends joControl
  constructor: (object) ->
    @title = object.title
    @titleLabel = new joLabel(@title)
    @startButton = new joButton("Start")
    
    @onSelect()
    
  getView: () ->
    @container = new joFlexrow()
    #container.push(new joImage())
    @container.push(new joLabel(@title))
    @container.push(new joLabel("Num slides"))
    @container.push(@startButton)
    @container
    
  onSelect: () ->
    self = this
    @startButton.selectEvent.subscribe(() ->
        joLog("hit start on", self.title)
    )
    
  toString: () ->
    @title
    
window.PresoListItem = PresoListItem