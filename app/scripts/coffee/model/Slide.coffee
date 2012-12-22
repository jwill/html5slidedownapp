class Slide
  constructor: (@index) ->
    if @index is undefined
      @index = 1
      
  setContent: (@data) ->  
  getContent: () -> @data
  setIndex: (@index) ->
  getIndex: () -> @index
  setVisible: (@isVisible) ->
  
  toString: () ->
    return """
      <article data-markdown>
      #{@data}
      </article>
    """

window.Slide = Slide