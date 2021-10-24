import Widget as ImbaCodeMirror from './codemirror'
import Widget as Details from './details-tooltype'

const source-code = '###\n@TAGS: ["p","div","blockquote","address"]\n@text-block:\n\tTYPE: "WYSIWYG"\n\tlegend: "Display text "\n\ttitle: "Display text"\n\tdescription: "Display text"\n###\nprop text-block default: "Display text"\ndef render\n\t<self html=@text-block>'

tag CompilerImbaCSS < iframe

	# def setData code
	# 	if dom:contentDocument
	# 		# # fn(dom:contentDocument:body)
	# 		let Tag = code.match( /defineTag\(\'(\w+)\'/ )[1];
	# 		code = "(function(ELM)\{ var { code.substring( code.indexOf '_1' ) } \} )()";
	# 		console.log code
	# 		console.log Function( code )()
			
	# 		# # let fn = Function('ELM', "return function(ELM)\{{code}\}");

	# 		# Imba.mount Tag, dom:contentDocument:body
	# 	self

	def render
		<self>

tag DraggableStateLayer < section

	def ontouchstart touch
		self

	def ontouchmove touch
		if touch.sourceTarget.flags.contains 'move-point' then css
			top: touch.y - touch.sourceTarget.dom:clientHeight * 1.5
			left: touch.x - touch.sourceTarget.dom:clientWidth * 1.5
			right: 'auto'
			bottom: 'auto'

tag ImbaDebugState < kbd

	def toggleActive
		@active = !@active

	def render
		<self .active=@active :tap.toggleActive>
			<svg:svg> <svg:use href="{ ISVG }#eye">
			<DraggableStateLayer :tap.stop>
				<aside>
					<kbd.move-point> <svg:svg> <svg:use href="{ ISVG }#move-layer">
					<abbr>
						<svg:svg> <svg:use href="{ ISVG }#eye">
						<span> "View and analysis of the status widget"
				<div>
					<hr>
					<CompilerImbaCSS[ data:js ]>
					<hr>

tag CreateSetting < form
	prop type-settings

	def build
		@editors = [
			"STRING"
			"NUMBER"
			"BOOLEAN"
			"DATE"
			"RANGE"
			"FILE"
			"LIST"
		]

	def changeType v
		data:type = v unless Imba.root.dom.click

	def render
		<self>
			<label>
				<input[data:name] type="text" placeholder=" " required pattern='^[a-zA-Z_][0-9a-zA-Z-_]*$'>
				<legend> "Enter name { type-settings }"
			<label>
				<input[data:title] type="text" placeholder=" " required>
				<legend> "Enter display name { type-settings }"
			<label>
				<textarea[data:description] placeholder=" " required>
				<legend> "Enter description { type-settings }"
			if @type-settings === 'Property' then <section.type-settings-Property>
				<span>  "Type editor property: "
				<Details>
					<summary.is-select> data:type
					<ul> for item in @editors
						<li .active=( data:type === item ) :tap.changeType(item)> item
			elif @type-settings === 'Event' then <section.type-settings-Event>
			elif @type-settings === 'Methods' then <section.type-settings-Methods>
			<button disabled=!dom.checkValidity .active=dom.checkValidity> "Insert { type-settings }"

export tag Header < h2
	prop current-version default: [0,0,0]

	def setup
		@latest = application.document.collection('versions').orderBy('updatedAt', 'desc').limit(1).response

	@classes = ['']

	def mount
		if application.document.response:version then @current-version = application.document.response:version.slice
		else application.document.response:version = @current-version.slice
		const changeVersionDocument = do|cm|
			if cm.getOption('mode') === 'imba' then application.document.response:sourceCode = cm.getValue
			else application.document.response:sourceStyle = cm.getValue
			cm:timeoutVersionChange = clearTimeout(cm:timeoutVersionChange) or setTimeout(&, 333 ) do render ++application.document.response:version[2]

		let interval = setInterval( &, 0 ) do
			@codemirror = parent and parent.querySelector( '.imba-codemirror' ).parent.@codemirror
			render @codemirror.cm.on('change', changeVersionDocument.bind self ) if @codemirror and not clearInterval interval

	def toggleAside t
		unless mode
			const aside = root.querySelector 'article + aside'
			aside.flagIf 'active', t isa Boolean ? t : not aside.flags.contains 'active'

	def toggleCodeMirror t
		if @codemirror
			toggleAside false
			@codemirror.cm.setOption 'mode', t
			@codemirror.cm.focus

	def mode
		@codemirror.@codemirror.getOption('mode') === 'css'

	def saveDocumentState e
		@waiting = application.updateDocument application.document.response, do @waiting = false

	def latest
		@latest and @latest[0]

	def isActiveSave
		@current-version.toString === application.document.response:version.toString

	def itTagMode
		@codemirror and @codemirror.cm:compiled and @codemirror.cm:compiled:imba and @codemirror.cm:compiled:imba:options and @codemirror.cm:compiled:imba:options:filename === 'Tag'

	def render
		<self>
			<span> <span contenteditable=true data-placeholder="Enter widget name"> application.document.response:displayName
			<dfn>
				<span contenteditable=true data-placeholder="Enter widget description">
			<aside>
				if itTagMode
					<kbd.code-imba .active=!mode  :tap.toggleCodeMirror('imba')> <svg:svg> <svg:use href="{ ISVG }#code-imba">
					<kbd.code-css .active=mode  :tap.toggleCodeMirror('css')> <svg:svg> <svg:use href="{ ISVG }#code-css">
					<ImbaDebugState[ @codemirror.cm:compiled:imba ]>
				if application.document.response:version
					<button.active.it-save-typo .waiting=@waiting :tap.saveDocumentState
						disabled=isActiveSave>
							"Save version: { ( application.document.response:version or [0,0,0] ).join '.' }"
					<kbd> <svg:svg> <svg:use href="{ ISVG }#dolly-flatbed">
				if @codemirror then <kbd :tap.toggleAside> <svg:svg> <svg:use href="{ ISVG }#bars">

export tag Navigation < section
	@classes = ['']
	def render
		<self>

export tag Aside < section
	@classes = ['']
	prop new-property default:
		name: ''
		title: ''
		type: 'STRING'
	prop new-event default:
		name: ''
		title: ''
		type: 'DEF'
	prop new-method default:
		name: ''
		title: ''
		type: 'DEF'

	def togglrFormCreateProperty v
		const hr = querySelector 'hr[data-step="🅥"]'
		hr.open = true
		@new-property = not hr.flags.contains( 'create-form' ) and Object.assign {},  v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def togglrFormCreateEvent v
		const hr = querySelector 'hr[data-step="🅔"]'
		hr.open = true
		@new-event = not hr.flags.contains( 'create-form' ) and Object.assign {},  v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def togglrFormCreateMethod v
		const hr = querySelector 'hr[data-step="🅜"]'
		hr.open = true
		@new-method = not hr.flags.contains( 'create-form' ) and Object.assign {},  v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def addTag e
		if Imba:HTML_TAGS.includes e.target.value.toLocaleLowerCase
			application.document.response:sourceTag = [ e.target.value.toLowerCase ].concat application.document.response:sourceTag or []
			e.target.value = ''
	def deleteTag item
		application.document.response:sourceTag.splice application.document.response:sourceTag.indexOf( item ), 1

	def checkValidityTag e
		unless Imba:HTML_TAGS.includes e.target.value.toLowerCase then e.target.pattern = '\d+'
		else e.target.pattern = '.+'

	def toggleLayer e
		let parent = e.target
		if parent:open isa Function then parent.open = !parent.open
		else until parent:open isa Function
			parent = parent.parent
			break parent.open = !parent.open if parent:open isa Function

	def render
		<self>
			<hr data-step="🅣" open=true :tap.toggleLayer>
				<legend> "Tag(s)"
			<section>
				<label.search-tag>
					<input type="text" list="Imba-HTML-TAGS" placeholder="div" :change.addTag :input.checkValidityTag>
					<i> <svg:svg> <svg:use href="{ ISVG }#search-plus">
				<datalist#Imba-HTML-TAGS> for item in Imba:HTML_TAGS when application.document.response and not ( application.document.response:sourceTag and application.document.response:sourceTag.includes item )
					<option> item
				if application.document.response then <ul> for item in application.document.response:sourceTag
					<li>
						<span> item
						<del :tap.deleteTag( item )> "⨂"
			<hr data-step="🅥" open=true :tap.toggleLayer>
				<legend> "Propertis"
				<aside> <kbd :tap.stop.togglrFormCreateProperty( @_new-property:default )> "+"
			<section>
				<CreateSetting[ @new-property ] type-settings="Property">
			<hr data-step="🅔" open=true :tap.toggleLayer>
				<legend> "Events"
				<aside> <kbd  :tap.stop.togglrFormCreateEvent( @_new-event:default )> "+"
			<section>
				<CreateSetting[ @new-event ] type-settings="Event">
			<hr data-step="🅜" open=true :tap.toggleLayer>
				<legend> "Methods"
				<aside> <kbd :tap.stop.togglrFormCreateMethod( @_new-method:default )> "+"
			<section>
				<CreateSetting[ @new-method ] type-settings="Method">

export tag Article < section
	@classes = ['widget-editor']

	prop default-state default:
		sourceCode: source-code
		sourceTag: 'div'
		version: [0,0,0]

	def render
		<self>
			<ImbaCodeMirror@codemirror>
			# console.log 'compiler', @codemirror.compiler if @codemirror.compiler
