ThemeHandler = require './ThemeHandler'
Direction = require './widgets/Direction'
console = require './console'
Form = require './widgets/Form'
require './polyfills'

window.console = console

module.exports = class Panel

	@console: console

	constructor: (@panelName, @rootNode = document.body) ->

		@console = console

		unless @console.native

			window.onerror = (e) ->

				console.error e

				no

		try

			@themeHandler = new ThemeHandler @

			Direction.applyTo @rootNode

			Form.applyTo @rootNode

		catch error

			if @console.native

				throw error

			else

				console.error error