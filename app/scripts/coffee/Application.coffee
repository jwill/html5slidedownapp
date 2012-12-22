class Application
  constructor: () ->
    @initializeFileSystem()
    
    jo.load()
    @stack = new joStack()
    @screen = new joScreen(@stack)
    
    @home_screen = new HomeScreen(@db)
    @stack.push(@home_screen.getView())
    
    @setupHotkeys()
    
    @presoCard = null
    @editorCard = null
  
  initializeFileSystem: () ->
    #@filer = new Filer()
    doNothing = (fs) ->
      
    #@filer.init({persistent: false, size: 10*1024 * 1024}, doNothing, @onError)
    
    # Create db
    self = this
    @db = new Lawnchair({name:'html5slidedown'}, doNothing )
  
  setupHotkeys: () ->
    self = this
    @k = new Kibo()
    @k.down('f1', () ->
      self.stack.back()
    )
    @k.down('f2', () ->
      self.stack.forward()
    )
  
  onError: (e) ->
    console.log('Error' + e.name)
    
  refreshPresentation: () ->
    onPageLoaded()
    handleDomLoaded()
  
    
window.Application = Application
window.app = new Application()
  
  