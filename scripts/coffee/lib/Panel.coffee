ThemeHandler = require './ThemeHandler'
CSInterface = require './CSInterface'
Direction = require './widgets/Direction'
Form = require './widgets/Form'

module.exports = class Panel

	constructor: (@panelName, @rootNode = document.body) ->

		window.__adobe_cep__.showDevTools()

		@csi = new CSInterface

		@themeHandler = new ThemeHandler @

		Direction.applyTo @rootNode, @

		Form.applyTo @rootNode, @