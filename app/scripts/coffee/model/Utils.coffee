class Utils
  constructor: () ->
    @header = """
      <!DOCTYPE html>
      <html>
      <head>
      <title></title>
      <meta charset='utf-8' />
      <script src='scripts/html5slidedown/slides.js'></script>
      <script src='scripts/html5slidedown/showdown.js'></script>
      <script src='scripts/html5slidedown/markdownify.js'></script>
      <script src='scripts/html5slidedown/ga.js'></script>
      </head>
    """
  
  convertImageURLToBase64: (url) ->
    image = new Image()
    canvas = document.createElement("canvas")
    image.onload = (i) ->
      canvas.width = image.width
      canvas.height = image.height
      ctx = canvas.getContext("2d")
      ctx.drawImage(image,0,0)
      joLog(canvas.toDataURL())
    image.src = url
  
window.Utils = Utils