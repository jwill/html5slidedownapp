class Presentation
  constructor: () ->
    @slides = []
    @title = null
  
  addSlide: (data) ->
    slide = new Slide(data)
    @slides.push(slide)
  
  loadPresentation: (data) ->
    @jsonData = data
    @setTitle(@jsonData.title)
    @parseSlides(@jsonData)
    
  generateKey: () ->
    @title.toLowerCase()
  
  parseSlides: (data) ->
    slides = []
    i = 1
    for slide in data.slides
      content = slide.content.join('<br/>\n')
      s = new Slide(i++)
      s.setContent(content)
      slides.push(s)
      console.log(content)
    @slides = slides
    
  setTitle: (@title) ->
  
  showPresentation: () ->
    slideText = ""
    
    slideText += slide.toString() for slide in @slides
    console.log(slideText)
    @html = new joHTML("<section class='slides layout-regular'>#{slideText}</section>")
    @card = new joCard([
      @html
      ])
    app.presoCard = @card
    app.stack.pop(app.presoCard)
    app.stack.push(app.presoCard)
    onPageLoaded()
    handleDomLoaded()
  
  toJSON: () ->
    obj = {title: @title, type:"presentation"}
    slides = []
    for slide in @slides
      o = {content: slide.getContent().split("<br/>\n")}
      slides.push(o)
    obj.slides = slides
    console.log(obj)
    obj
  
  # mostly for export (optional)
  createHTMLFile: () ->
    # join header from utils
    # <body style='display: none'>
    # <section class='slides layout-regular'>
    # Slides
    # </section></body></html>
      
window.Presentation = Presentation