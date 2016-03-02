{BufferedProcess} = require 'atom'
{CompositeDisposable} = require 'atom'

module.exports = OpenDocsExternal =
  activate: ->
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace',
      'salt:docs': => @saltDocs()

  saltDocs: ->
    # This assumes the active pane item is an editor
    if editor = atom.workspace.getActiveTextEditor()
      symbol = editor.getSelectedText().trim().replace(":", "")
      [module, method] = symbol.split(".")

      command = "open"
      urlBase = "http://docs.saltstack.com/en/latest/ref/states/all/salt.states.#{module}.html"
      hashUrl = if method then "#salt.states.#{module}.#{method}" else ""
      args = ["#{urlBase}#{hashUrl}"]

      stdout = (output) -> console.log(output)
      stderr = (output) -> console.log(output)
      exit = (code) -> console.log("salt:doc exit code #{code}")

      console.log args
      process = new BufferedProcess({command, args, stdout, exit, stderr})
