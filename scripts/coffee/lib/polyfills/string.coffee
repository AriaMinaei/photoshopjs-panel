do ->

	return if typeof String("").trim is 'function'

	String::trim = ->

		String(@).replace(/^\s+/, '').replace(/\s+$/, '')