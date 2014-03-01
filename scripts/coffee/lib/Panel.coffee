ThemeHandler = require './ThemeHandler'
console = require './console'
require './polyfills'

module.exports = class Panel

	@console: console

	constructor: (@panelName) ->

		@console = console

		unless @console.native

			window.onerror = (e) ->

				console.error e

				no

		try

			@themeHandler = new ThemeHandler @

		catch error

			console.error error