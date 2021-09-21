import Widget as ImbaCodeMirror from './codemirror'

tag CreateSetting < form
	prop type-settings
	def render
		<self>
			<label>
				<input type="text" placeholder=" ">
				<legend> "Enter name { type-settings }"
			<label>
				<textarea placeholder=" ">
				<legend> "Enter description { type-settings }"
			<button disabled=true> "Insert { type-settings }"

export tag Header < h2
	@classes = ['']
	def toggleAside t
		unless mode
			const aside = root.querySelector 'article + aside'
			aside.flagIf 'active', t isa Boolean ? t : not aside.flags.contains 'active'

	def codemirror
		unless @codemirror then @codemirror = parent and parent.querySelector( '.imba-codemirror' ).parent.@codemirror.@codemirror
		@codemirror

	def toggleCodeMirror t
		if codemirror
			toggleAside false
			codemirror.setOption 'mode', t
			codemirror.focus

	def mode
		codemirror.getOption('mode') === 'css'

	def render
		<self>
			<span> <span contenteditable=true data-placeholder="Enter widget name">
			<dfn> <span contenteditable=true data-placeholder="Enter widget description">
			<aside>
				if codemirror
					<kbd.code-imba .active=!mode  :tap.toggleCodeMirror('imba')> <svg:svg> <svg:use href="{ ISVG }#code-imba">
					<kbd.code-css .active=mode  :tap.toggleCodeMirror('css')> <svg:svg> <svg:use href="{ ISVG }#code-css">
				<button.active disabled=true> "Save version: default"
				<kbd> <svg:svg> <svg:use href="{ ISVG }#dolly-flatbed">
				if codemirror then <kbd :tap.toggleAside> <svg:svg> <svg:use href="{ ISVG }#bars">

export tag Navigation < section
	@classes = ['']
	def render
		<self>

export tag Aside < section
	@classes = ['']
	prop new-property default:
		name: ''
		title: ''
	prop new-event default:
		name: ''
		title: ''
	prop new-method default:
		name: ''
		title: ''

	def togglrFormCreateProperty v
		const hr = querySelector 'hr[data-step="🅥"]'
		@new-property = not hr.flags.contains( 'create-form' ) and v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def togglrFormCreateEvent v
		const hr = querySelector 'hr[data-step="🅔"]'
		@new-event = not hr.flags.contains( 'create-form' ) and v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def togglrFormCreateMethod v
		const hr = querySelector 'hr[data-step="🅜"]'
		@new-method = not hr.flags.contains( 'create-form' ) and v
		hr.flagIf 'create-form', not hr.flags.contains 'create-form'

	def render
		<self>
			<hr data-step="🅥" open=true>
				<legend> "Propertis"
				<aside> <kbd :tap.togglrFormCreateProperty( @_new-property:default )> "+"
			<section>
				<CreateSetting[ @new-property ] type-settings="Property">
			<hr data-step="🅔" open=true>
				<legend> "Events"
				<aside> <kbd  :tap.togglrFormCreateEvent(  @_new-event:default )> "+"
			<section>
				<CreateSetting[ @new-event ] type-settings="Event">
			<hr data-step="🅜" open=true>
				<legend> "Methods"
				<aside> <kbd :tap.togglrFormCreateMethod( @_new-method:default )> "+"
			<section>
				<CreateSetting[ @new-method ] type-settings="Method">

export tag Article < section
	@classes = ['']
	def render
		<self>
			<ImbaCodeMirror@codemirror>