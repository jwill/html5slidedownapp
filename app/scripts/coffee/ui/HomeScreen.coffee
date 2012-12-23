class HomeScreen
  constructor: (@db) ->
    
    @currentPreso = null
    
    @list = new joFlexcol()
    @menu = new joFlexrow()
    
    @view = new joCard([
      new joTitle("Presentations")
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
    @list.clear()
    @db.all((items) ->
      titles = []
      for item in items
        # Add to collection if a presention
        if item.hasOwnProperty("type") && item["type"] == "presentation"
          self.presos.push(item) 
          listItem = new PresoListItem(item)
          #listItem.isManageListItem(false)
          titles.push(listItem.getView())
      self.list.push(titles)
      # No presos to display suggest creating one
      self.list.push(new joFlexrow([new joLabel("Create a preso")])) if titles.length == 0
    )

window.HomeScreen = HomeScreen