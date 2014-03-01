console = require './console'

module.exports = class ThemeHandler

	constructor: (@panel) ->

		@current = 'light1'

		window.addEventListener 'ThemeChangedEvent', @_themeChangeListener

		@_changeTheme 'dark1', 'Tahoma', '10'

	_themeChangeListener: (e) =>

		theme = switch e.appSkinInfo.panelBackgroundColor

			when 'b8b8b8' then 'light1'

			when 'd6d6d6' then 'light2'

			when '343434' then 'dark1'

			else 'dark2'

		@_changeTheme theme, e.appSkinInfo.baseFontFamily, e.appSkinInfo.baseFontSize

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