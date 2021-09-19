
import './index.styl'

const IW = require './icons-symbols.svg'

import TransformSettings,
	ZIndexSettings,
	BoxShadowSettings,
	BackgroundSettings,
	OpacitySettings,
	FlexSettings,
	BoxSizingSettings,
	BorderSettings,
	PaddingSettings,
	MarginSettings,
	GridSettings,
	FontSettings,
	TextAlignSettings,
	TextTransformSettings
	from './settings'

export tag CSSLayerSettings < section
	prop actives default: []

	def toggleStateBlock t
		if  @actives.includes t then @actives.splice @actives.indexOf( t ), 1
		else @actives.push t

	def render
		<self>
			<nav>
				<kbd .active=@actives.includes('box-shadow')
					:tap.toggleStateBlock('box-shadow') > <svg:svg> <svg:use href="{ IW }#box-shadow-settings">
				<kbd .active=@actives.includes('background')
					:tap.toggleStateBlock('background') > <svg:svg> <svg:use href="{ IW }#background-settings">
				<kbd .active=@actives.includes('opacity')
					:tap.toggleStateBlock('opacity')> <svg:svg> <svg:use href="{ IW }#opacity-settings">
				<kbd .active=@actives.includes('z-index')
					:tap.toggleStateBlock('z-index')> <svg:svg> <svg:use href="{ IW }#z-index-settings">
				<kbd .active=@actives.includes('transform')
					:tap.toggleStateBlock('transform')> <svg:svg> <svg:use href="{ IW }#transform-settings">
			<TransformSettings[data] .active=@actives.includes('transform')>
			<ZIndexSettings[data] .active=@actives.includes('z-index')>
			<OpacitySettings[data] .active=@actives.includes('opacity')>
			<BackgroundSettings[data] .active=@actives.includes('background')>
			<BoxShadowSettings[data] .active=@actives.includes('box-shadow')>

export tag CSSBlockSettings < section
	prop actives default: []

	def toggleStateBlock t
		if  @actives.includes t then @actives.splice @actives.indexOf( t ), 1
		else @actives.push t

	def render
		<self>
			<nav>
				<kbd .active=@actives.includes('margin')
					:tap.toggleStateBlock('margin') > <svg:svg> <svg:use href="{ IW }#margin-settings">
				<kbd .active=@actives.includes('padding')
					:tap.toggleStateBlock('padding') > <svg:svg> <svg:use href="{ IW }#padding-settings">
				<kbd .active=@actives.includes('border')
					:tap.toggleStateBlock('border')> <svg:svg> <svg:use href="{ IW }#border-settings">
				<kbd .active=@actives.includes('box-sizing')
					:tap.toggleStateBlock('box-sizing')> <svg:svg> <svg:use href="{ IW }#box-sizing-settings">
				<kbd .active=@actives.includes('flex')
					:tap.toggleStateBlock('flex')> <svg:svg> <svg:use href="{ IW }#flex-settings">
			<MarginSettings[data] .active=@actives.includes('margin')>
			<PaddingSettings[data] .active=@actives.includes('padding')>
			<BorderSettings[data] .active=@actives.includes('border')>
			<BoxSizingSettings[data] .active=@actives.includes('box-sizing')>
			<FlexSettings .active=@actives.includes('flex')>

export tag CSSGridSettings < GridSettings

export tag CSSFontSettings < section
	def render
		<self>
			<section>
				<span> "Text"
				<span> "Title"
				<span> "Extra"
				<aside>
			<FontSettings>

export tag CSSTextSettings < section
	def render
		<self>

export tag CSSTextSettings < section
	def render
		<self>
			<section>
				<kbd> <svg:svg> <svg:use href="{ IW }#first-letter">
				<TextAlignSettings>
				<TextTransformSettings>
				<aside>
					<kbd> <svg:svg> <svg:use href="{ IW }#text-decoration">
					<kbd> <svg:svg> <svg:use href="{ IW }#text-shadow">
					<kbd> <svg:svg> <svg:use href="{ IW }#text-shadow">

export tag CSSTransactionSettings < section
	def render
		<self>
			"CSSTransactionSettings"