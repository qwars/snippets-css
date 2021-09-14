
import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'
import Widget as CreateButton from './create-button'

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
			if params:document then <ElementNavigation route="/widgets/:document">

export tag Aside < aside
	def render
		<self>
			if params:document then <ElementAside route="/widgets/:document">

export tag Article < article

	def addSearchTags
		@tags

	def createNewFolder
		@count = 0 unless @count
		@count += 1

	def createNewElement e
		e.target.waiting = Promise.new do|response|
			setTimeout(&, 3000) do e.target.waiting = undefined

	def toggleNavigate
		@nav-active = !@nav-active

	def render
		<self#WidgetArticle>
			unless params:document then <h2>
				<span>
					<kbd :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#folder-plus">
					"Widgets"
				<dfn>
				<aside>
					<CreateButton :submit.createNewElement>
				<blockquote>
					<kbd :tap.toggleNavigate> <svg:svg> <svg:use href="{ ISVG }#bars">
					<label>
						<input type="text" placeholder="Search widgets">
						<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			else <ElementHeader route="/widgets/:document">
			unless params:document then <section.list-state>
				<nav .active=@nav-active>
					<ul> for item in Array @count or 0
						<li>
							<kbd> <svg:svg> <svg:use href="{ ISVG }#folder">
							<span> "Random text Random text Random text Random text"
							<aside>
								<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">
					<.trash-folder>
						<kbd> <svg:svg> <svg:use href="{ ISVG }#folder-times">
						<span> "Trash"
						<aside>
							<kbd> <svg:svg> <svg:use href="{ ISVG }#trash-undo">
							<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">

				<ul> for item in Array 20
					<li> <ItemFigure>
			else <ElementArticle route="/widgets/:document">
