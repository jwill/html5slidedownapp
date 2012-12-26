class Presentation
  constructor: () ->
    @slides = []
    @title = null
    @images = []
    
  addImageFromURL: (cssTitle, url) ->
    data = null
    convertImageURLToBase64(url,cssTitle)
  
  addSlide: (data) ->
    slide = new Slide(data)
    @slides.push(slide)
  
  loadPresentation: (data) ->
    @jsonData = data
    @setTitle(@jsonData.title)
    @images = @jsonData.images if @jsonData.images isnt undefined
    @parseSlides(@jsonData)
    
  generateKey: () ->
    @title.toLowerCase()
  
  parseSlides: (data) ->
    slides = []
    i = 1
    for slide in data.slides
      content = slide.content.join('\n')
      s = new Slide(i++)
      s.setContent(content)
      slides.push(s)
      console.log(content)
    @slides = slides
    window.preso = this
    
  setTitle: (@title) ->
  
  showPresentation: () ->
    slideText = ""
    
    slideText += slide.toString() for slide in @slides
    #console.log(slideText)
    
    @html = new joHTML("<section class='slides layout-regular'>\n#{slideText}</section>")
    @card = new joCard([
      @html
      ])
    app.presoCard = @card
    app.stack.pop(app.presoCard)
    app.stack.push(app.presoCard)
    onPageLoaded()
    handleDomLoaded()
    @processImages()
    
  processImages: () ->
    for image in @images
      divs = document.querySelectorAll("img[src=#{image.cssClassName}]")
      for div in divs
        div.src = image.data
  
  toJSON: () ->
    obj = {title: @title, type:"presentation"}
    slides = []
    for slide in @slides
      o = {content: slide.getContent().split("<br/>\n")}
      slides.push(o)
    obj.slides = slides
    obj.images = @images
    console.log(obj)
    obj
  
  addImageFromURL: (cssTitle, url) ->
    image = new Image()
    canvas = document.createElement("canvas")
    self = this
    image.onload = (i) ->
      canvas.width = image.width
      canvas.height = image.height
      ctx = canvas.getContext("2d")
      ctx.drawImage(image,0,0)
      data = canvas.toDataURL()
      self.images.push({cssClassName:cssTitle, data:data})
    image.src = url
  
  # mostly for export (optional)
  createHTMLFile: () ->
    # join header from utils
    # <body style='display: none'>
    # <section class='slides layout-regular'>
    # Slides
    # </section></body></html>
      
window.Presentation = Presentation
