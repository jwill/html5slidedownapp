class CreateTitleCard
  constructor: (@data) ->
    @card = new joCard([
      new joTitle("Create A Presentation")
      new joLabel("Name of talk:")
      @talkTitle = new joInput()
      #new joLabel("Twitter:")
      #@twitterId = new joInput()
      #new joLabel("Google+:")
      #@gplusLink = new joInput()
      new joFooter([
        @okButton = new joButton("OK")
        @cancelButton = new joButton("Cancel")
      ])
    ])

    if @data isnt undefined
      @changingTitle = true
      @talkTitle.setData(@data)

    @onSelect()

  getView: () -> @card

  createNewPreso: () ->
    self = this
    preso = new Presentation()
    title = self.talkTitle.getData()
    preso.setTitle(title)
    preso.addSlide(
      "# #{title}\n\n#{new Date()}"
    )
      
    json = preso.toJSON()
    json.key = title.toLowerCase()
    app.db.save(json, () ->
      app.home_screen.getPresentations()
      app.screen.hidePopup()
    )

  changeTitle: () ->
    self = this
    oldTitleKey = self.data.toLowerCase()
    title = self.talkTitle.getData()
    newTitleKey = title.toLowerCase()

    app.db.get(oldTitleKey, (oldJSON) ->
      console.log(oldJSON)
      oldJSON.key = title.toLowerCase()
      oldJSON.title = title
      app.db.save(oldJSON, () ->
        app.db.remove(oldTitleKey)
        app.home_screen.getPresentations()
        app.screen.hidePopup()
      )
    )

  onSelect: () ->
    self = this
    @okButton.selectEvent.subscribe(() ->
      if self.changingTitle then self.changeTitle() else self.createNewPreso()
    )
    @cancelButton.selectEvent.subscribe(() ->
      app.screen.hidePopup()
    )
    

window.CreateTitleCard = CreateTitleCard
