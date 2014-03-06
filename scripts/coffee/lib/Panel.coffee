ThemeHandler = require './ThemeHandler'
CSInterface = require './CSInterface'
Rotator = require './widgets/Rotator'
Form = require './widgets/Form'

module.exports = class Panel

	constructor: (@panelName, @rootNode = document.body) ->

		window.__adobe_cep__.showDevTools()

		@csi = new CSInterface

		@themeHandler = new ThemeHandler @

		Rotator.applyTo @rootNode, @

		Form.applyTo @rootNode, @