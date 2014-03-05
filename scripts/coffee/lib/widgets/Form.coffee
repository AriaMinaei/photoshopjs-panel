module.exports = class Form

	constructor: (@node) ->

		@node.addEventListener 'submit', (e) =>

			e.preventDefault()

			do @_submit

	_submit: ->

		data = {}

		for input in @node.querySelectorAll 'input'

			data[input.name] = input.value

		json = JSON.stringify data

		@_wire json

	_wire: (data) ->

		action = @node.action

		unless matches = action.match /\#([a-zA-Z0-9\/\.\s\_\-]+)\:([a-zA-Z0-9\_]+)$/

			throw Error "Couldn't parse action address '#{action}'"

		path = matches[1]
		method = matches[2]

		try

			_AdobeInvokeFunctionInScriptFile path, '_panel', method, [data]

		catch e

			console.log e

		return

	@applyTo: (rootNode) ->

		for form in rootNode.querySelectorAll 'form'

			if String(form.getAttribute('action')).match /^#/

				new Form form

		return