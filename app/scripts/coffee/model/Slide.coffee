class Slide
  constructor: (@index) ->
    if @index is undefined
      @index = 1
      
  setContent: (@data) ->  
  getContent: () -> @data
  setIndex: (@index) ->
  getIndex: () -> @index
  setVisible: (@isVisible) ->
  
  toString: (imageData) ->
    return """
      <article data-markdown>
      #{@data}
      </article>\n\n
    """

window.Slide = Slide