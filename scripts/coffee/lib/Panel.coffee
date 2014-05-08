OpenInBrowserHelper = require './widgets/OpenInBrowserHelper'
UpdateNotifier = require './panel/UpdateNotifier'
ThemeHandler = require './ThemeHandler'
CSInterface = require './CSInterface'
Rotator = require './widgets/Rotator'
Form = require './widgets/Form'

module.exports = class Panel

	constructor: (@panelName, @rootNode = document.body) ->

		@rootNode.addEventListener 'click', (e) ->

			if e.ctrlKey and e.shiftKey

				window.__adobe_cep__.showDevTools()

			return

		@csi = new CSInterface

		@themeHandler = new ThemeHandler @

		Rotator.applyTo @rootNode, @

		Form.applyTo @rootNode, @

		OpenInBrowserHelper.applyTo @rootNode, @

		@updateNotifier = new UpdateNotifier @