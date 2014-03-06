module.exports = class Form

	constructor: (@panel, @node) ->

		@csi = @panel.csi

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

		unless matches = action.match /\#([a-zA-Z0-9\_]+)$/

			throw Error "Couldn't parse action address '#{action}'"

		method = matches[1]

		try

			src = "$.global._panels." + method + "(#{data});"

			console.log src

			@csi.evalScript src, (ret) ->

				console.log arguments

		catch e

			console.log e

		return

	@applyTo: (rootNode, panel) ->

		for form in rootNode.querySelectorAll 'form'

			if String(form.getAttribute('action')).match /^#/

				new Form panel, form

		return