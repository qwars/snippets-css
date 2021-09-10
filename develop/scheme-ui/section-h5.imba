
tag SectionNav < section
	def render
		<self>
			<dfn>
				"Пример создания табов в теге"
				<samp> <q> 'FIELDSET'
			<p> <code>
			<em>
				'Если у тега'
				<samp> <q> 'A'
				'нет ссылки якоря на раздел, тогда нужно добавлять класс'
				<samp> <q> '.active'
				'-'
				<q> 'вручную'

export tag Sketch < section
	@classes = []

	def render
		<self>
			<fieldset>
				<legend>
					<nav>
						<ol>
							<li> <a route-to="#Nav" .is-active=!router.hash > "Навигация или табы"
							<li> <a route-to="#Fieldset">
								<span> "Тег "
								<samp> <q> "FIELDSET"
							<li> <a route-to="#Fields"> "Поля ввода данных"
							<li> <a route-to="#Selection"> "Поля ввода выбора список"
							<li> <a route-to="#Date"> "Поля ввода выбора даты"
					<aside> <kbd> <svg:svg> <svg:use href="#icon-code-html">
				<SectionNav route="/-/*$">
				<SectionNav route="#Nav"> "#Nav"
				<section route="#Fieldset"> "#Fieldset"
				<section route="#Fields"> "#Fields"
				<section route="#Selection"> "#Selection"
				<section route="#Date"> "#Date"
