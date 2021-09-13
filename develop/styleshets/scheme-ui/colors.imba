
import { colord } from 'colord'

import ColorEditor, DefsGradients from '../../widgets/editor-wysiwyg/colors-collection'

tag PalletColor

	def iD
		unless @iD
			@iD = Math.random.toString.replace /\D/g, ''
		@iD

	def changeColor e
		trigger 'changecolor', colord e.data

	def toggleOpen
		dom.setAttribute 'open', true

	def render
		<self.colors-collection  id="L-G-{ iD }" :tap.toggleOpen>
			<DefsGradients[ parent.data ] id="G-{ iD }">
			<ColorEditor[ parent.data ] live-hue=true :input.changeColor >

tag VariableColor
	def render
		<self>
			<span> "Value: "
			<b> parent.data.toRgbString

tag ItemLi < li
	def render
		<self
			css:backgroundColor=data.toRgbString
			css:color=( data.alpha <= .15 or data.isLight ? 'black' : 'white' )>

export tag Sketch < article
	@classes=['ui-colors']

	def build
		document:body.addEventListener 'click', do|e| for item in Imba.root.querySelectorAll '.PalletColor[open]'
			item.dom.removeAttribute 'open' unless item.dom === e:target

	def setup
		const getColorsMap = do for item in $1 when item.includes '-color'
			[ item, colord $1.getPropertyValue item ]
		@cssRule =
			light: document:styleSheets[ document:styleSheets:length - 1 ]:cssRules[ document:styleSheets[ document:styleSheets:length - 1 ].insertRule ':root {}' , document:styleSheets[ document:styleSheets:length - 1 ]:cssRules:length ]
			dark: document:styleSheets[ document:styleSheets:length - 1 ]:cssRules[ document:styleSheets[ document:styleSheets:length - 1 ].insertRule 'body.prefers-color-scheme-dark {}' , document:styleSheets[ document:styleSheets:length - 1 ]:cssRules:length ]
		for item in document:styleSheets
			for rule in item:cssRules when rule:media and rule:conditionText.includes 'color'
				if rule:conditionText.includes 'light' then for shets in rule:cssRules when shets:selectorText == ':root'
					Object.defineProperty @cssRule:light, 'vars',
						value: Map.new getColorsMap shets:style
				if rule:conditionText.includes 'dark' then for shets in rule:cssRules when shets:selectorText == ':root'
					Object.defineProperty @cssRule:dark, 'vars',
						value: Map.new getColorsMap shets:style

		if window.matchMedia( '(prefers-color-scheme: light)' ):matches then @activeSheet = @cssRule:light
		else @activeSheet = @cssRule:dark

	def togglePrefersColorScheme
		Imba.root.flag 'prefers-color-scheme-dark',  not Imba.root.flags.contains 'prefers-color-scheme-dark'

	def setActiveSheet
		if Imba.root.flags.contains 'prefers-color-scheme-dark' then @activeSheet = @cssRule:dark
		else @activeSheet = @cssRule:light

	def changecolorSet k
		do
			@activeSheet:vars.set k, $1.data

	def render
		<self>
			<h2>
				<span> "Colors"
				<dfn>
				<aside>
					<kbd :tap.togglePrefersColorScheme.setActiveSheet > <svg:svg> <svg:use href="{ ISVG }#prefers-color-scheme">
			<section>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--canvas-color' ] :changecolor=changecolorSet('--canvas-color')>
						<span> "Canvas color"
						<div>
							"VAR: "
							<b> "--canvas-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--border-color' ] :changecolor=changecolorSet('--border-color')>
						<span> "Border color"
						<div>
							"VAR: "
							<b> "--border-color "
						<VariableColor>
						<PalletColor>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--title-color' ] :changecolor=changecolorSet('--title-color')>
						<span> "Title text color"
						<div>
							"VAR: "
							<b> "--title-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--text-color' ] :changecolor=changecolorSet('--text-color')>
						<span> "Main text color"
						<div>
							"VAR: "
							<b> "--text-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--extra-color' ] :changecolor=changecolorSet('--extra-color')>
						<span> "Extra text color"
						<div>
							"VAR: "
							<b> "--extra-color "
						<VariableColor>
						<PalletColor>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--active-color' ] :changecolor=changecolorSet('--active-color')>
						<span> "Active element color"
						<div>
							"VAR: "
							<b> "--active-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--visited-color' ] :changecolor=changecolorSet('--visited-color')>
						<span> "Visited element color"
						<div>
							"VAR: "
							<b> "--visited-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--link-color' ] :changecolor=changecolorSet('--link-color')>
						<span> "Link element color"
						<div>
							"VAR: "
							<b> "--link-color "
						<VariableColor>
						<PalletColor>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--hover-color' ] :changecolor=changecolorSet('--hover-color')>
						<span> "Hover element color"
						<div>
							"VAR: "
							<b> "--hover-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--focus-color' ] :changecolor=changecolorSet('--focus-color')>
						<span> "Focus element color"
						<div>
							"VAR: "
							<b> "--focus-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--checked-color' ] :changecolor=changecolorSet('--checked-color')>
						<span> "Checked element color"
						<div>
							"VAR: "
							<b> "--checked-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--select-color' ] :changecolor=changecolorSet('--select-color')>
						<span> "Select element color"
						<div>
							"VAR: "
							<b> "--select-color "
						<VariableColor>
						<PalletColor>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--placeholder-color' ] :changecolor=changecolorSet('--placeholder-color')>
						<span> "Placeholder input color"
						<div>
							"VAR: "
							<b> "--placeholder-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--disabled-color' ] :changecolor=changecolorSet('--disabled-color')>
						<span> "Disabled element color"
						<div>
							"VAR: "
							<b> '--disabled-color'
						<VariableColor>
						<PalletColor>
				<ul>
					<ItemLi[ @activeSheet:vars.get '--invalid-color' ] :changecolor=changecolorSet('--invalid-color')>
						<span> "Invalid element color"
						<div>
							"VAR: "
							<b> "--invalid-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--info-color' ] :changecolor=changecolorSet('--info-color')>
						<span> "Info element color"
						<div>
							"VAR: "
							<b> "--info-color "
						<VariableColor>
						<PalletColor>
					<ItemLi[ @activeSheet:vars.get '--warning-color' ] :changecolor=changecolorSet('--warning-color')>
						<span> "Warning element color"
						<div>
							"VAR: "
							<b> "--warning-color "
						<VariableColor>
						<PalletColor>
