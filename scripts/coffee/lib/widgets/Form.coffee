module.exports = class Form

	constructor: (@node) ->

		console.log @node

		@node.addEventListener 'submit', (e) =>

			e.preventDefault()

			do @_submit

	_submit: ->

		data = {}

		for input in @node.querySelectorAll 'input'

			data[input.name] = input.value

		console.log JSON.stringify data

	@applyTo: (rootNode) ->

		for form in rootNode.querySelectorAll 'form'

			if String(form.getAttribute('action')).match /^#/

				new Form form

		return