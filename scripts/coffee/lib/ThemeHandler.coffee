console = require './console'

module.exports = class ThemeHandler

	constructor: (@panel) ->

		@current = 'light1'

		@_changeTheme 'dark1', 'Tahoma', '10'

		@panel.csi.addEventListener @panel.csi.constructor.THEME_COLOR_CHANGED_EVENT, @_themeChangeListener

		do @_themeChangeListener

	_themeChangeListener: =>

		skin = @panel.csi.hostEnvironment.appSkinInfo

		color = skin.panelBackgroundColor.color

		theme = if color.red > 200

			'light2'

		else if color.red > 120

			'light1'

		else if color.red > 75

			'dark2'

		else

			'dark1'

		@_changeTheme theme, skin.baseFontFamily, skin.baseFontSize

	_changeTheme: (theme, fontFamily, fontSize) ->

		html = document.querySelector 'html'
		body = document.body

		body.style.fontFamily = fontFamily

		body.style.fontSize = fontSize + 'px'

		for t in ['light1', 'light2', 'dark1', 'dark2', 'light', 'dark']

			html.classList.remove t

		html.classList.add theme

		if theme in ['light1', 'light2']

			html.classList.add 'light'

		else

			html.classList.add 'dark'

		@current = theme

	isLight: ->

		@current in ['light1', 'light2']