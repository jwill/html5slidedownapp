class HomeScreen
  constructor: (@db) ->
    
    @currentPreso = null
    
    @list = new joFlexcol()
    @menu = new joFlexrow()
    
    @view = new joCard([
      new joTitle("Manage Presentations")
      @menu
      @list
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
    @db.all((items) ->
      titles = []
      for item in items
        # Add to collection if a presention
        if item.hasOwnProperty("type") && item["type"] == "presentation"
          self.presos.push(item) 
          titles.push(new PresoListItem(item).getView())
      self.list.push(titles)
    )
    # create new items for them

    
    # add items to list using setData([])
    return @presos

window.HomeScreen = HomeScreen