class CodeEditor
  constructor: (@preso) ->
    @html = new joHTML('<div id="editor"></div>')
    @card = new joCard([
      @html
      ])
    app.stack.pop(app.editorCard)
    app.editorCard = @card
    app.stack.push(app.editorCard)
    app.stack.push(app.editorCard)
    
    @editor = ace.edit("editor")
    @editor.setTheme("ace/theme/chrome")
    #@editor.getSession().setMode("ace/mode/javascript")
    @setupFunctions()
    
  changeTheme: (theme) ->
    @editor.setTheme(theme)
    
  setValue: (text) ->
    @editor.setValue(text)
  
  saveFile: (editor) ->
    numLines = editor.getSession().getLength()
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
      else 
        slideLines.push line
    presentation = {
      title: @preso.title
      type:"presentation"
      slides: slides
      key: @preso.generateKey()
    }
    
    app.db.save(presentation)
    
    console.log slides
  
  setupFunctions: () ->
    self = this
    @editor.commands.addCommand({
      name: 'saveCommand',
      bindKey: {win: 'Ctrl-S',  mac: 'Command-S'},
      exec: (editor) ->
        self.saveFile(editor)
    });
    
  

window.CodeEditor = CodeEditor