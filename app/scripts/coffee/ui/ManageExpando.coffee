class ManageExpando
  constructor: (@object) ->
    @editButton = new joButton("Edit")
    @deleteButton = new joButton("Delete")
    @changeTitleButton = new joButton("Change Title")
    @themeButton = new joButton("Change Theme")
    @manageAssetsButton = new joButton("Manage Assets")
    
    @view = new joExpando([
      new joExpandoTitle("Manage"),
      new joExpandoContent([
        @manageAssetsButton
        @editButton
        @deleteButton
        new joDivider()
        @changeTitleButton
        @themeButton
      ])
    ])
    
    @manageAssetsDialog = new joCard([
      new joTitle("Manage Files")
      new joFooter([
        new joButton("Close")  
      ])
    ])
    
    
    @onSelect()
  
  notImplemented: () ->
    app.screen.alert("Not Implemented.")
    
  getView: () ->
    return @view
  
  onSelect: () ->
    self = this
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
    @deleteButton.selectEvent.subscribe(() ->
      #app.screen.alert("Deleted Presentation.")
      key = self.object.title.toLowerCase()
      app.db.remove(key, ()->
        # TODO Refresh display
        app.screen.alert("Removed "+self.object.title)
        
      )
    )
    @manageAssetsButton.selectEvent.subscribe(() ->
      #self.notImplemented()  
      app.stack.push(self.manageAssetsDialog)
    )
    @themeButton.selectEvent.subscribe(() ->
      self.notImplemented()  
    )
    @changeTitleButton.selectEvent.subscribe(() ->
      self.notImplemented()  
    )

window.ManageExpando = ManageExpando