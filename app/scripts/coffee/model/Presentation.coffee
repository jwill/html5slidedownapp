class Presentation
  constructor: () ->
    @slides = []
    @title = null
  
  addSlide: (data) ->
    slide = new Slide(data)
    @slides.push(slide)
  
  loadPresentation: () ->
    # Remove hardcoded bits later
    result = null
    filename = "https://c9.io/jwill/html5slidedownapp/workspace/app/preso-sample.json"
    self = this
    handler = (x, text) ->
      result = text
      self.jsonData = JSON.parse(result)
      # Set title
      self.setTitle(self.jsonData.title)
      # Parse slides
      self.parseSlides(self.jsonData)

    joFile(filename, handler, null, 10)
  
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
    window.app.stack.push(@card)
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
      
  markdownify: (source, target) ->
    # Might need to use DOMParser
    # Get all of the article elements with the data-markdown attribute.
    articles = document.querySelectorAll('article[data-markdown]');
    converter = new Showdown.converter();
    for article in articles
      # Replace the contents of the article with its markdownified version.
      html = converter.makeHtml(article.innerHTML);
      article.innerHTML = html;
      
window.Presentation = Presentation