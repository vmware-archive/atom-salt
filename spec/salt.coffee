url = require 'url'
sys = require("sys")
exec = require("child_process").exec

module.exports =
  activate: ->
    atom.workspaceView.command "salt:docs", => @saltDocs()
  saltDocs: ->
    # This assumes the active pane item is an editor
    editor = atom.workspace.activePaneItem
    symbol = editor.getTextInBufferRange(editor.bufferRangeForScopeAtCursor("entity.name.tag.yaml"))
    [module, method] = symbol.replace(":", "").split(".")

    urlBase = "http://docs.saltstack.com/ref/states/all/salt.states.#{module}.html"
    hashUrl = if method then "#salt.states.#{module}.#{method}" else ""
    # executes `pwd`
    exec "open '#{urlBase}#{hashUrl}'", (error, stdout, stderr) ->
      console.log "exec error: " + error  if error isnt null
      return
