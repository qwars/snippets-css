import Widget as ImbaCodeMirror from './codemirror'
import Widget as Details from './details-tooltype'
import Widget as ColorsHue from './editor-wysiwyg/colors-collection/colors-hue'

const markdownFile = require( '../../assets/mdnDocs/files/en-us/web/events/index.md' ):default;

const TARGETS = for item of document when item.match /^on/i
	item

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

	const fns = 'return (function (el){\n'
	const fnm = "\nel.innerHTML = el.style.filter = '';\nImba.mount(Imba.createElementFactory()(TagCompilerCodeMirrorStateTemp).end(), el)"
	const fne = '\n})(el)'

	def setData v
		if @iframe and @iframe.dom:contentDocument and v
			let fn = Function.new 'el', "{ fns } const { v:imba:js.slice v:imba:js.indexOf '_1' }{ fnm }{ fne }"
			@iframe.dom:contentDocument:body:style:margin = '0px'
			@iframe.dom:contentDocument:body:style:filter = 'opacity(0.5) blur(1px)'
			@waiting = clearTimeout(@waiting) or setTimeout(&, 333) do render @waiting = fn @iframe.dom:contentDocument:body
			unless @iframe.dom:contentDocument:head:lastChild then @iframe.dom:contentDocument:head.appendChild( document.createElement 'style' ):textContent = v:css and v:css:sourceCode or ''
			else @iframe.dom:contentDocument:head:lastChild:textContent = v:css and v:css:sourceCode or ''
			@data = v
		self

	def toggleActive
		@active = !@active

	def togglePortrait
		@portrait = !@portrait

	def render
		<self .active=@active :tap.toggleActive>
			<svg:svg> <svg:use href="{ ISVG }#eye"> if data
			<DraggableStateLayer :tap.stop .is-waiting=@waiting .media-portrait=@portrait>
				<aside>
					<kbd.move-point> <svg:svg> <svg:use href="{ ISVG }#move-layer">
					<abbr>
						<span> "View and analysis of the status widget"
					<kbd.media-state :tap.togglePortrait> <svg:svg> <svg:use href="{ ISVG }#mobile-alt">
				<div>
					<hr>
					<iframe@iframe>
					<hr>

tag CreateSetting < form
	prop type-settings

	def build
		@editors = [
			"STRING"
			"WYSIWYG"
			"NUMBER"
			"BOOLEAN"
			"DATE"
			"RANGE"
			"FILE"
			"LIST"
		]

	def changeType v
		data:type = v unless Imba.root.dom.click

	def checkValidityEvents e
		if type-settings === 'Event'
			if e.target.value
				unless TARGETS.includes e.target.value.toLowerCase then e.target.pattern = '\d+'
				else e.target.pattern = '.+'
			else e.target.pattern = '.+'

	def render
		<self :submit.stop.prevent.submitForm>
			<label .search-tag-event=(type-settings === 'Event')>
				<input[data:name] list="data-list-{type-settings}" type="text" placeholder=" " required pattern='^[a-zA-Z_][0-9a-zA-Z-_]*$' :input.checkValidityEvents>
				<i> <svg:svg> <svg:use href="{ ISVG }#search-plus"> if @type-settings === 'Event' 
				<legend> "Enter name { type-settings }"
			if @type-settings === 'Event' then <datalist#data-list-Event> for item in TARGETS
				<option> item
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
			elif @type-settings === 'Method' then <section.type-settings-Methods>
				<.settings-values>
					"Inputs: "
				<.settings-values>
					"Output: "
			<button disabled=!dom.checkValidity .active=dom.checkValidity> "Insert { type-settings }"

tag PropertiesSettings < ul
	def render
		<self> # console.log data:js
tag MethodsSettings < ul
	def render
		<self>
tag EventsSettings < ul
	def render
		<self>

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
		if mode
			const aside = root.querySelector 'article + aside'
			aside.flagIf 'active', t isa Boolean ? t : not aside.flags.contains 'active'

	def toggleCodeMirror t
		if @codemirror
			toggleAside false
			@codemirror.cm:compiled[ @codemirror.cm.getOption 'mode' ]:cursor = @codemirror.cm.getCursor if @codemirror.cm:compiled
			@codemirror.cm.setOption 'mode', t
			if @codemirror.cm:compiled and @codemirror.cm:compiled[t] and @codemirror.cm:compiled[t]:sourceCode then @codemirror.cm.setValue @codemirror.cm:compiled[t]:sourceCode
			else @codemirror.cm.setValue ''
			@codemirror.cm.focus
			@codemirror.cm.setCursor @codemirror.cm:compiled[t]:cursor if @codemirror.cm:compiled and @codemirror.cm:compiled[t] and @codemirror.cm:compiled[t]:cursor

	def mode
		@codemirror and @codemirror.cm.getOption('mode') === 'imba'

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
			<blockquote>
				# <kbd> <svg:svg> <svg:use href="{ ISVG }#bars"
				unless itTagMode then <section> "Class"
				elif mode then <section> "Template"
				else
					<section> "Style"
					<aside.settings-template>
						<Details>
							<summary.is-font-text> "Text"
							<s>
						<Details>
							<summary.is-font-title> "Title"
							<s>
						<Details>
							<summary.is-font-extra> "Extra"
							<s>
						for item in [ ['red',''], ['blue',''], ['green',''] ]
							<Details>
								<summary.{ 'is-color-' + item[0] } :css.backgroundColor=(item[1] or item[0])>
								<s> <ColorsHue[ item[1] or item[0] ] :choice=(do|e| item[1] = e.data )>

			<aside>
				<kbd.code-imba .active=mode  :tap.toggleCodeMirror('imba')> <svg:svg> <svg:use href="{ ISVG }#code-imba">
				<kbd.code-css .active=!mode  :tap.toggleCodeMirror('css')> <svg:svg> <svg:use href="{ ISVG }#code-css">
				<ImbaDebugState[@codemirror.cm:compiled]> if @codemirror
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
		type: 'EVENT'
	prop new-method default:
		name: ''
		title: ''
		type: 'DEF'

	def mount

		let interval = setInterval( &, 0 ) do
			@codemirror = parent and parent.parent and parent.parent.querySelector '.imba-codemirror'
			render if @codemirror and not clearInterval interval


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

	def createNewProperty target
		const template = "\n\t@{ target.data:name }:{ target.data:type } { target.data:title }\n\t\t{ target.data:description.trim.replace /\n/, '\n\t\t' }"
		const propname = "\nprop {target.data:name}"
		let start-fragment = "###{ template }\n###{ propname }";
		unless @codemirror.cm:compiled and @codemirror.cm:compiled:imba and @codemirror.cm:compiled:imba:options then @codemirror.cm.setValue start-fragment
		else
			let code = @codemirror.cm:compiled:imba:options:_tokens.filter do $1:_type === 'HERECOMMENT'
			if code:length === 0 then @codemirror.cm.setValue "{ start-fragment }\n{@codemirror.cm.getValue}"
			else
				let last-fragment = @codemirror.cm:compiled:imba:sourceCode.slice 3 + code[0]:_value:length + @codemirror.cm:compiled:imba:sourceCode.indexOf code[0]:_value
				start-fragment = "###{code[0]:_value}{ template }\n###{ propname }"
				@codemirror.cm.setValue "{ start-fragment }{ last-fragment }"

		@codemirror.cm.setCursor start-fragment.split(/\n/):length - 1, propname:length - 1
		@codemirror.cm.focus

	def createNewEvent target
		const template = "\n\t{ target.data:name }:{target.data:type} { target.data:title }\n\t\t{ target.data:description.trim.replace /\n/, '\n\t\t' }"
		let start-fragment = "###{ template }\n###\ndef { target.data:name } e\n\t\n\tself\n";
		let pos = 5
		unless @codemirror.cm:compiled and @codemirror.cm:compiled:imba and @codemirror.cm:compiled:imba:options then @codemirror.cm.setValue start-fragment
		else
			let code = @codemirror.cm.getValue.split /(def\s+render)/
			code.splice 1, 0, start-fragment
			@codemirror.cm.setValue code.join ''
			pos = code.slice( 0, 2 ).join('\n').split(/\n/):length - 4

		@codemirror.cm.setCursor pos, 1
		@codemirror.cm.focus

	def createNewMethod target
		const property = do "\t\t\t - { $1:name }:{ $1:type } { $1:title }{ $1:description.trim and '\n\t\t\t\t'}{ $1:description.trim }"
		const inputs = do ["","\t\tinputs:"].concat( target.data:inputs.map(property).concat("") ).join "\n" if target.data:inputs
		const output = do ["","\t\toutput:", "\t\t\t{ target.data:output:type } {  }", "" ].joun "\n" if target.data:output
		const template = "\n\t{ target.data:name }:{target.data:type} { target.data:title }\n\t\t{ target.data:description.trim.replace /\n/, '\n\t\t' }{ inputs or '' }{ output or 'self' }"
		let start-fragment = "###{ template }\n###\ndef { target.data:name } \n\t\n";
		let pos = 5
		unless @codemirror.cm:compiled and @codemirror.cm:compiled:imba and @codemirror.cm:compiled:imba:options then @codemirror.cm.setValue start-fragment
		else
			let code = @codemirror.cm.getValue.split /(def\s+render)/
			code.splice 1, 0, start-fragment
			@codemirror.cm.setValue code.join ''
			pos = code.slice( 0, 2 ).join('\n').split(/\n/):length - 4

		@codemirror.cm.setCursor pos, 1
		@codemirror.cm.focus

	def submitForm e
		if e.target.type-settings === 'Property' then togglrFormCreateProperty createNewProperty e.target
		elif e.target.type-settings === 'Event' then createNewEvent e.target
		elif e.target.type-settings === 'Method' then createNewMethod e.target

	def render
		<self>
			unless @codemirror then <.loading>
			else
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
							<del :tap.deleteTag( item )> "⮿"
				<hr data-step="🅥" open=true :tap.toggleLayer>
					<legend> "Propertis"
					<aside> <kbd :tap.stop.togglrFormCreateProperty( @_new-property:default )> "+"
				<section>
					<CreateSetting[ @new-property ] type-settings="Property">
					<PropertiesSettings[@codemirror.cm:compiled:imba]> if @codemirror.cm:compiled
				<hr data-step="🅔" open=true :tap.toggleLayer>
					<legend> "Events"
					<aside> <kbd  :tap.stop.togglrFormCreateEvent( @_new-event:default )> "+"
				<section>
					<CreateSetting[ @new-event ] type-settings="Event">
					<EventsSettings[@codemirror.cm:compiled:imba]> if @codemirror.cm:compiled
				<hr data-step="🅜" open=true :tap.toggleLayer>
					<legend> "Methods"
					<aside> <kbd :tap.stop.togglrFormCreateMethod( @_new-method:default )> "+"
				<section>
					<CreateSetting[ @new-method ] type-settings="Method">
					<MethodsSettings[@codemirror.cm:compiled:imba]> if @codemirror.cm:compiled

export tag Article < section
	@classes = ['widget-editor']
	def render
		<self> <ImbaCodeMirror@codemirror>
