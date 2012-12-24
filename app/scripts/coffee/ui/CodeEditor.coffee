class CodeEditor
  constructor: (@preso) ->
    @html = new joHTML('<div id="editor"></div>')
    @card = new joCard([
      @html
      ])
    app.stack.pop(app.editorCard)
    app.editorCard = @card
    app.stack.push(app.editorCard)
    
    @editor = ace.edit("editor")
    @editor.setTheme("ace/theme/chrome")
    @editor.getSession().setMode("ace/mode/javascript")
    @setupFunctions()
    document.removeEventListener('keydown', handleBodyKeyDown, false)
    
  changeTheme: (theme) ->
    @editor.setTheme(theme)
    
  setValue: (text) ->
    @editor.setValue(text)
  
  compileSlides: (editor, numLines) ->
    openedArticle = false
    slideLines = []
    slides = []
    
    for i in [0..numLines]
      line = editor.getSession().getLine(i)
      if line.indexOf("<article data-markdown>") != -1
        openedArticle = true
      else if line.indexOf("</article>") != -1
        # close slide
        obj = {content:slideLines}
        slides.push obj
        slideLines = []
        openedArticle = false
      else if openedArticle
        slideLines.push line
    return slides
    
  saveFile: (editor) ->
    numLines = editor.getSession().getLength()
    slides = @compileSlides(editor, numLines)
    
    presentation = {
      title: @preso.title
      type:"presentation"
      slides: slides
      images: @preso.images
      key: @preso.generateKey()
    }
    
    app.db.save(presentation, () ->
      app.home_screen.getPresentations()
    )
    app.screen.alert("Saved file.")
  
  setupFunctions: () ->
    self = this
    @editor.commands.addCommand({
      name: 'saveCommand'
      bindKey: {win: 'Ctrl-Y',  mac: 'Command-Y'},
      exec: (editor) ->
        self.saveFile(editor)
    });
    
  

window.CodeEditor = CodeEditor