class HomeScreen
  constructor: (@db) ->
    @list = new joFlexcol()
    @createButton = new joButton("Create A Presentation")
    
    @view = new joCard([
      new joTitle("Presentations")
      @list
      new joFlexrow([@createButton])
      new joFooter([new joLabel("Footer")])
    ])
    
    @getPresentations()
    @onSelect()
    
  getView: () ->
    return @view
  
  onSelect: () ->
    self = this
    #@list.selectEvent.subscribe( (id) ->
    #  console.log(id)
    #  self.currentPreso = self.presos[id]
    #)
   
  getPresentations: () ->
    # get list of presentations from db
    @presos = []
    self = this
    @list.clear()
    @db.all((items) ->
      titles = []
      for item in items
        # Add to collection if a presention
        if item.hasOwnProperty("type") && item["type"] == "presentation"
          self.presos.push(item) 
          listItem = new PresoListItem(item)
          titles.push(listItem.getView())
      self.list.push(titles)
    )

window.HomeScreen = HomeScreen