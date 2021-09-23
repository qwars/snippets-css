
import Widget as Details from '../widgets/details-tooltype'
import Widget as ColorsHue from '../widgets/editor-wysiwyg/colors-collection/colors-hue'
import CSSLayerSettings,
	CSSBlockSettings,
	CSSGridSettings,
	CSSFontSettings,
	CSSTextSettings,
	CSSTransactionSettings
	from '../widgets/styleshets-settings'


const state-editor =
	media: null
	view-grid: true

tag ItemLiFolders < li
	def render
		<self>
			<kbd :tap.editWidgesFolder> <svg:svg> <svg:use href="{ ISVG }#dolly">
			<span> "Random tex tRandom text Random text Random text"
			<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">

tag DropWidget < span
	prop item
	def ondragover e
		e.prevent

	def ondragenter e
		e.prevent
		flagIf 'active-state', true unless flags.contains 'active-state'

	def ondragleave e
		e.prevent
		flagIf 'active-state', false

	def ondrop e
		e.prevent
		flagIf 'active-state', false
		trigger 'create', root:dataTransfer

tag MediaState

	def mount
		let factor-height = Number dom:parentElement and dom:parentElement:clientHeight - dom:clientHeight
		@media-height =
			true: dom:clientHeight - factor-height
			false: dom:clientWidth  / ( 16/9 ) - factor-height
		let factor-width = Number dom:parentElement and dom:parentElement:clientWidth - dom:clientWidth
		@media-width =
			true: dom:clientHeight / ( 16/9 ) - factor-width
			false: dom:clientWidth - factor-width

	def computed
		if @framestate.dom:contentDocument then window.getComputedStyle @framestate.dom:contentDocument:body
		else {}

	def renderAnimation e
		render

	def media-width
		@media-width ? @media-width[ flags.contains 'state-portrait' ] : '0px'

	def media-height
		@media-height ? @media-height[ flags.contains 'state-portrait' ] : '0px'

	def current-columns
		computed:gridTemplateColumns

	def current-rows
		computed:gridTemplateRows

	def column-gap
		computed:columnGap or computed:gridColumnGap

	def row-gap
		computed:rowGap or computed:gridRowGap

	def current-gap
		computed:gap

	def current-grid-gap
		computed:griGap

	def count-items
		for row, idr in toArray current-rows
			for col, idc in toArray current-columns
				{ idc: idc + 1, idr: idr + 1, row: row.replace(/none|auto/, '') , col: col.replace(/none|auto/, '')  }

	def toArray value
		value and value.split /\s+/

	def render
		<self>
			<div.current-frame>
				<div.current-grid
					css:gridTemplateColumns=current-columns
					css:gridTemplateRows=current-rows
					css:rowGap=row-gap
					css:rowGap=column-gap
					css:gap=current-gap
					css:gridGap=current-grid-gap
					>
					if current-rows then for items, idx in count-items
						''
						for item, idx in items
							<DropWidget .col-none=!item:col .row-none=!item:row :create.createNewWidget item=item :tap.selectPoint>

				<iframe@framestate
					width=media-width
					height=media-height
					:animationend.renderAnimation
					:transitionend.renderAnimation>

			<div.current-columns>
				<div css:width=media-width
					css:gridTemplateColumns=current-columns
					css:gap=current-gap>
					for item, idx in toArray current-columns
						<span> <s css:marginRight="-{column-gap}" css:width=column-gap css:height="{ dom:parentElement:clientHeight }px">
			<div.current-rows>
				<div css:height=media-height
					css:gridTemplateRows=current-rows
					css:gap=current-gap>
					for item, idx in toArray current-rows
						<span> <s css:marginBottom="-{ row-gap }" css:height=row-gap css:width="{ dom:parentElement:clientWidth }px">

export tag Header < h2
	@classes = ['']

	def toggleNavigation
		let nav = Imba.root.querySelector 'main > nav'
		nav.flagIf 'active', not nav.flags.contains 'active'

	def toggleMediaState
		state-editor:media = not state-editor:media

	def toggleGridState
		state-editor:view-grid = not state-editor:view-grid

	def render
		<self>
			<span> <span contenteditable=true data-placeholder="Enter template name">
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
					<kbd.not-active
						.state-portrait=state-editor:media
						.state-landscape=!state-editor:media
						:tap.toggleMediaState> <svg:svg> <svg:use href="{ ISVG }#mobile-alt">
					<kbd .active=state-editor:view-grid :tap.toggleGridState> <svg:svg> <svg:use href="{ ISVG }#th">
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

	@classes = ['template-editor']

	def mount
		state-editor:media = @mediastate.dom:clientHeight > @mediastate.dom:clientWidth
		render

	def render
		<self>
			<section> <MediaState@mediastate
				.state-portrait=state-editor:media
				.state-landscape=!state-editor:media
				.view-grid=state-editor:view-grid>
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
