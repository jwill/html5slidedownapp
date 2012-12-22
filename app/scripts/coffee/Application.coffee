class Application
  constructor: () ->
    @initializeFileSystem()
    
    jo.load()
    @stack = new joStack()
    @screen = new joScreen(@stack)
    
    @home_screen = new HomeScreen(@db)
    @stack.push(@home_screen.getView())
  
  initializeFileSystem: () ->
    #@filer = new Filer()
    doNothing = (fs) ->
      
    #@filer.init({persistent: false, size: 10*1024 * 1024}, doNothing, @onError)
    
    # Create db
    self = this
    @db = new Lawnchair({name:'html5slidedown'}, doNothing )
      
  onError: (e) ->
    console.log('Error' + e.name)
    
  refreshPresentation: () ->
    onPageLoaded()
    handleDomLoaded()
  
    
window.Application = Application
window.app = new Application()
  
  