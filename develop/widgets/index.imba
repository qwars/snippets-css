
import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'
import Article as Page404 from '../page404'
import Widget as CreateButton from './create-button'
import Widget as PaginationFrestoreCollection from './pagination-frestore-collection'

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

	def createNewFolder e
		# 'Simple Tags'
		e.target.parent.children[0].dom:validity:valid and application.createFolder({ displayName: e.target.parent.children[0].value })
			.then do render e.target.parent.children[0].value = ''

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
			unless params:documen then <h2>
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
					<label.search-tag-event>
						<input type="text" placeholder="Enter new folder name" required=true :keydown.enter.createNewFolder>
						<i :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#folder-plus">
					unless application.folders.response then <.loading>
					else <ul>
						for item in Array(4).fill application.folders.response[0]
							<li .active=(item:id === application.collection) title=item.data:displayName :tap.selectFolder(item)>
								<kbd> <svg:svg> <svg:use href="{ ISVG }#folder">
								<span> item.data:displayName
								<aside>
									<del.kbd :tap.stop.removeFolder( item:ref )> <svg:svg> <svg:use href="{ ISVG }#trash">
					<.trash-folder>
						<kbd> <svg:svg> <svg:use href="{ ISVG }#folder">
						<span> "Trash"
						<aside>
							<kbd> <svg:svg> <svg:use href="{ ISVG }#trash-undo">
							<del.kbd> <svg:svg> <svg:use href="{ ISVG }#trash">
				<ul> for item in application.collection.response
					<li> <ItemFigure>
				<PaginationFrestoreCollection[ application.collection ]>
			elif application.document.response isa Object then <ElementArticle route="/widgets/:document">
			elif application.document.response === null then <Page404 route="/:collection/:document">
			else <.loading>
