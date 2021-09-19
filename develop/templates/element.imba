
import Widget as Details from '../widgets/details-tooltype'
import Widget as ColorsHue from '../widgets/editor-wysiwyg/colors-collection/colors-hue'
import CSSLayerSettings,
	CSSBlockSettings,
	CSSGridSettings,
	CSSFontSettings,
	CSSTextSettings,
	CSSTransactionSettings
	from '../widgets/styleshets-settings'

tag ItemLiFolders < li
	def render
		<self>
			<kbd :tap.editWidgesFolder> <svg:svg> <svg:use href="{ ISVG }#dolly">
			<span> "Random tex tRandom text Random text Random text"
			<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">

export tag Header < h2
	@classes = ['']

	def toggleNavigation
		let nav = Imba.root.querySelector 'main > nav'
		nav.flagIf 'active', not nav.flags.contains 'active'

	def render
		<self>
			<span>
				<kbd> <svg:svg> <svg:use href="{ ISVG }#image">
				<span contenteditable=true data-placeholder="Enter template name">
			<dfn> <span contenteditable=true data-placeholder="Enter template description">
			<blockquote>
				<kbd :tap.toggleNavigation> <svg:svg> <svg:use href="{ ISVG }#bars">
				<section>
					<kbd :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#dolly">
					<dfn> <b> "Default widgets"
					<section.wigets-folder>
						for item in Array 25
							<kbd> <svg:svg> <svg:use href="{ ISVG }#image">
						# <em.announcement> "Empty folder"
				<aside.settings-template>
					<kbd> <svg:svg> <svg:use href="{ ISVG }#mobile-alt">
					<kbd> <svg:svg> <svg:use href="{ ISVG }#th">
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
							<summary.{ 'is-color-' + item[0] }>
							<s> <ColorsHue[ item[1] or item[0] ]>

					<kbd :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#cog">
			<aside>
				<button.active disabled=true> "Save version: default"
				<kbd> <svg:svg> <svg:use href="{ ISVG }#dolly-flatbed">

export tag Navigation < section
	@classes = ['widgets-collection-folders']

	def createNewFolder
		console.log @input.value

	def render
		<self>
			<label>
				<input type="text" placeholder="Enter new folder name" required=true>
				<i :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#folder-plus">
			<ul>
				for item in Array 140
					<ItemLiFolders>
			<.trash-folder>
				<kbd> <svg:svg> <svg:use href="{ ISVG }#folder-times">
				<span> "Trash"
				<aside>
					<kbd> <svg:svg> <svg:use href="{ ISVG }#trash-undo">
					<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">


export tag Aside < section
	def render
		<self>

export tag Article < section
	def render
		<self>
			<section>
			<aside>
				<h4>
					<span contenteditable=true :keydown.ctrl.prevent :keydown.enter.prevent> "Widget Widget Widget an a i Widget Widget"
					<del>
				if false then <section>
					<hr data-step="🅑" open=true>
						<legend> "Background"
						<aside> <kbd> "+"
					<section>
					<hr data-step="🅒" open=true>
						<legend> "Cols"
						<aside> <kbd> "+"
					<section>
					<hr data-step="🅡" open=true>
						<legend> "Rows"
						<aside> <kbd> "+"
					<section>
				else
					<section>
						<hr data-step="🅟" open=true>
							<legend> "Properties"
						<hr data-step="🅖" open=true>
							<legend> "Grid position"
						<CSSGridSettings>
						<hr data-step="🅕" open=true>
							<legend> "Fonts state"
						<CSSFontSettings>
						<hr data-step="🅕" open=true>
							<legend> "Text settings"
						<CSSTextSettings>
						<hr data-step="🅣" open=true>
							<legend> "Transaction settings"
						<CSSTransactionSettings>
						<hr data-step="🅑" open=true>
							<legend> "Block settings"
						<CSSBlockSettings>
						<hr data-step="🅛" open=true>
							<legend> "Layer settings"
						<CSSLayerSettings>
