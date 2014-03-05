if window.console?

	module.exports = window.console

	window.console.native = yes

	return

module.exports = console =

	inspectLimit: 100

	native: no

	_inspectSingle: (given, persist = {limit: console.inspectLimit, covered: []}) ->

		r = ''

		if given is null

			return 'null'

		if typeof given in ['object', 'function']

			if given in persist.covered

				return '[Recursive]'

			else

				persist.covered.push given

			items = []

			iterator = (v, k) ->

				persist.limit--

				return if persist.limit <= 0

				k = k + " -> "

				try items.push k + console._inspectSingle(v, persist)

			if given instanceof Element

				type = "<#{given.tagName}>"

				subs = {}

				for prop in ['id', 'className', 'action']

					if given[prop]? and given[prop].length > 0

						subs[prop] = given[prop]

				if given.childElementCount > 0

					subs.children = given.children

				for name, val of subs

					iterator val, name

			else if given instanceof Array

				type = 'array'

				iterator(v, i) for v, i in given

			else

				if typeof given is 'function'

					type = '#Function'

				else

					type = '#Object'

					if given.constructor?.name?

						name = given.constructor.name

						if name isnt 'Object'

							type = '#' + name

				for k of given

					continue if k in ['prototype', 'parent']

					try

						v = given[k]

						iterator(v, k)

			r = prependToEachLine ("\n" + items.join(", \n")), '   '

		else if given is undefined

			return 'undefined'

		else if typeof given is 'string'

			if given.length > 200

				given = given.substr 0, 200

			return '"' + given + '"'

		else if typeof given in ['boolean', 'number']

			return String given

		else

			r = given

		unless type

			type = typeof given

		type + ' -> ' + r

	_inspect: ->

		r = []

		r = for v in arguments

			console._inspectSingle(v)

		r.join("   ", r)

	log: ->

		@alert.apply @, arguments

	alert: ->

		alert(@_inspect.apply(@, arguments))

	error: (e) ->

		console.log 'Error', e

	notice: ->

		alert("Notice: " + Array.from(arguments).join(" "))

	type: (v) ->

		t = typeof v

		if t in ['string', 'number', 'boolean']

			alert(t + ': ' + v)

		alert(v)

prependToEachLine = (str, toPrepend) ->

	String(str).split("\n").join("\n" + toPrepend)