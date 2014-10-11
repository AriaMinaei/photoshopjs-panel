window.CC = window.__adobe_cep__?
require './polyfills'

OpenInBrowserHelper = require './widgets/OpenInBrowserHelper'
UpdateNotifier = require './panel/UpdateNotifier'
ThemeHandler = require './ThemeHandler'
CSInterface = require './CSInterface' if window.CC
Rotator = require './widgets/Rotator'
Form = require './widgets/Form'

module.exports = class Panel

	constructor: (@panelName, @rootNode = document.body, @options) ->

		if window.CC

			@csi = new CSInterface

		@themeHandler = new ThemeHandler @

		Rotator.applyTo @rootNode, @

		Form.applyTo @rootNode, @

		OpenInBrowserHelper.applyTo @rootNode, @

		@updateNotifier = new UpdateNotifier @

	setPersistency: (isOn, id) ->

		return unless window.CC

		if isOn

			event = new CSInterface.CSEvent("com.adobe.PhotoshopPersistent", "APPLICATION")

		else

			event = new CSInterface.CSEvent("com.adobe.PhotoshopUnPersistent", "APPLICATION")

		event.extensionId = id
		@csi.dispatchEvent(event)