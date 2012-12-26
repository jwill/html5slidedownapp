class Slide
  constructor: (@data) ->
      
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
