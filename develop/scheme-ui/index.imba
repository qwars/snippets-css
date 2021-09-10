# https://html5book.ru/css3-sposoby-pisma/

import './index.styl'

import Sketch as SectionH1 from './section-h1'
import Sketch as SectionH2 from './section-h2'
import Sketch as SectionH3 from './section-h3'
import Sketch as SectionH4 from './section-h4'
import Sketch as SectionH5 from './section-h5'
import Sketch as SectionH6 from './section-h6'
import Sketch as SectionICON from './section-icon'

export tag Sketch < article
	@classes = []
	prop curent-step default: 0

	def setCurrentStep e
		@curent-step = Number( e.target.parent.dom:dataset:step ) === @curent-step or Number e.target.parent.dom:dataset:step

	def curent-step n
		@curent-step === n

	def render
		<self#SchemeUI>
			<h1>
				<span>
					<b> "Тег - H1 :: "
					"SchemeUI"
				<dfn>
					<b> "Тег - DFN :: "
					"Элементы <h1-h6> представляют заголовки для своих разделов. Эти элементы имеют ранг, определяемый числом в их имени."
				<aside>
					<b> "Тег - ASIDE :: "
					"Боковая колонка"
					<kbd> <svg:svg> <svg:use href="#code-html">
			<nav.navigation-tabs> <ul>
				<li route-to="{ params:path }" .not-active=(  [ "#Widgets", "#Icons", "#External" ].includes( router.hash ) )> "Семантика"
				<li route-to="#Widgets"> "Виджеты"
				<li route-to="#Icons"> "Иконки"
				<li route-to="#External"> "NPM пакеты"
			if not [ "#Widgets", "#Icons", "#External" ].includes( router.hash ) or not router.hash then <section>
				<hr data-step="1" open=(@curent-step === 1)>
					<legend :click.setCurrentStep> "Элементы формы"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH5>
				<hr data-step="2" open=(@curent-step === 2)>
					<legend :click.setCurrentStep> "Элементы, формирующие разделы HTML-документа"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH1>
				<hr data-step="3" open=(@curent-step === 3)>
					<legend :click.setCurrentStep> "Элементы для группировки содержимого веб-страниц"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH2>
				<hr data-step="4" open=(@curent-step === 4)>
					<legend :click.setCurrentStep> "Элементы для текстового содержимого"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH3>
				<hr data-step="5" open=(@curent-step === 5)>
					<legend :click.setCurrentStep> "Элементы для редактирования документа"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH4>
				<hr data-step="6" open=(@curent-step === 6)>
					<legend :click.setCurrentStep> "Audio и Video"
					<aside>
						<kbd> <svg:svg> <svg:use href="#code-html">
				<SectionH4>

			<section route="#Widgets">
				"Widgets"
			<SectionICON#Icons route="#Icons">