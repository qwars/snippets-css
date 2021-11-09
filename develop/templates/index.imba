import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'
import Widget as CreateButton from '../widgets/create-button'
import Widget as PaginationFrestoreCollection from '../widgets/pagination-frestore-collection'

const EmptyDataCollection = require '../images/empty-data-collection.svg'

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
			if params:document then <ElementNavigation route="/templates/:document">
export tag Aside < aside
	def render
		<self>
			if params:document then <ElementAside route="/templates/:document">


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
		<self>

			unless params:document then <h2>
				<span> "Templates"
				<dfn>
				<aside>
					<CreateButton :submit.createNewElement placeholder="templates">

				<blockquote>
					<kbd :tap.toggleNavigate> <svg:svg> <svg:use href="{ ISVG }#bars">
					<label>
						<input type="text" placeholder="Search templates">
						<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			else <ElementHeader route="/templates/:document">

			unless params:document then <section.list-state>
				<nav .active=@nav-active>
					<label.search-tag-event>
						<input type="text" placeholder="Enter new folder name" required=true :kewdown.enter.createNewFolder>
						<i :tap.createNewFolder> <svg:svg> <svg:use href="{ ISVG }#folder-plus">
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
				unless @pagination and @pagination.collection.response isa Array then <.loading>
				elif @pagination.collection.response:length === 0 then <div.is-empty-list-data>
					<abbr> <svg:svg> <svg:use href="{ EmptyDataCollection }#empty-data-collection">
					<em.announcement> "You have not created templates yet, do it right now"
				else <ul> for item in @pagination.collection.response
					<li> <ItemFigure>
				<PaginationFrestoreCollection[ application.collection ]@pagination>
			else <ElementArticle route="/templates/:document">
