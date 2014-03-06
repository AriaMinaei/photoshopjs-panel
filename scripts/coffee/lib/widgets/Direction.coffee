console = require '../console'

module.exports = class Direction

	constructor: (@node) ->

		@name = @node.getAttribute('data-name') or 'direction'

		options = @node.getAttribute 'data-options'

		if options? and options.trim() isnt ''

			@options = []

			for o in options.split(/\s*,\s*/)

				unless o in ['right', 'down', 'left', 'up']

					throw Error "Option '#{o}' isn't supported for direction. Supported options: ['right', 'down', 'left', 'up']"

				@options.push o

		else

			@options = ['right', 'down', 'left', 'up']

		@node.classList.add 'panel-input-direction'

		thingy = document.createElement 'div'
		thingy.classList.add 'thingy'

		@node.appendChild thingy

		@input = document.createElement 'input'
		@input.type = 'hidden'
		@input.name = @name

		@node.parentNode.appendChild @input

		@set @node.getAttribute('data-default') or @options[0]

		@node.addEventListener 'click', @rotate

	set: (to) ->

		unless to in @options

			throw Error "Option '#{to}' isn't defined."

		if @current? then @node.classList.remove @current

		@node.classList.add to

		@current = to

		@input.value = to

		@

	rotate: =>

		newIndex = @options.indexOf(@current) + 1

		newIndex = newIndex % @options.length

		@set @options[newIndex]

		@

	@applyTo: (root) ->

		nodes = root.querySelectorAll '[data-type="direction"]'

		for node in nodes

			new Direction node

		return