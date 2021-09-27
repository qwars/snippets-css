
import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'
import Article as Page404 from '../page404'
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

	def removeFolder ref
		application.removeFolder ref

	def createNewElement e
		e.target.waiting = application.createDocument
			Object.assign { displayName: e.data, folder: undefined }, ElementArticle:prototype.@_defaultState:default or {}
			do e.target.waiting = undefined

	def toggleNavigate
		@nav-active = !@nav-active

	def render
		<self>
			unless params:document then <h2>
				<span>
					<span> "Widgets"
					<q> "Folder"
				<dfn>
				<aside>
					<CreateButton :submit.createNewElement placeholder="widget">
				<blockquote>
					<kbd :tap.toggleNavigate> <svg:svg> <svg:use href="{ ISVG }#bars">
					<label>
						<input type="text" placeholder="Search widgets">
						<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			elif application.document.response isa Object then <ElementHeader route="/widgets/:document">
			unless params:document then <section.list-state>
				<nav .active=@nav-active>
					<label>
						<input type="text" placeholder="Enter new folder name" required=true :kewdown.enter.createNewFolder>
						<i :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#folder-plus">
					<ul>
						for item in Array @count or 0
							<li>
								<kbd> <svg:svg> <svg:use href="{ ISVG }#folder">
								<span> item.displayName
								<aside>
									<del.kbd :tap.removeFolder( item:ref )> <svg:svg> <svg:use href="{ ISVG }#trash">
					<.trash-folder>
						<kbd> <svg:svg> <svg:use href="{ ISVG }#folder">
						<span> "Trash"
						<aside>
							<kbd> <svg:svg> <svg:use href="{ ISVG }#trash-undo">
							<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">
				<ul> for item in Array 20
					<li> <ItemFigure>
			elif application.document.response isa Object then <ElementArticle route="/widgets/:document">
			elif application.document.response === null then <Page404 route="/:collection/:document">
			else <.loading>
