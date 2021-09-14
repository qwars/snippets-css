
import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'

tag ItemFigure < figure
	def render
		<self>
			<del>
			<img>
			<aside>
			<figcaption>

export tag Navigation < nav
	def render
		<self>
			<ElementNavigation route="/widgets/:document">

export tag Aside < aside
	def render
		<self>
			<ElementAside route="/widgets/:document">

export tag Article < article

	def addSearchTags
		@tags

	def render
		<self#WidgetArticle>
			unless params:document then <h2>
				<span> "Widgets"
				<dfn> 
				<aside>
				<blockquote>
					<label>
						<input type="text" placeholder="Search widgets">
						<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			else <ElementHeader route="/widgets/:document">
			unless params:document then <section> <ul> for item in Array 20
				<li> <ItemFigure>
			else <ElementArticle route="/widgets/:document">
