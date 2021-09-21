
import './index.styl'

import Aside as ElementAside, Navigation as ElementNavigation, Article as ElementArticle, Header as ElementHeader from './element'
import Aside as ElementAsideEditor, Navigation as ElementNavigationEditor, Article as ElementArticleEditor, Header as ElementHeaderEditor from './element-editor'

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
			if params:document then <ElementNavigationEditor route="/stores/:part/:document">
			elif params:document then <ElementNavigation route="/stores/:part/:document">


export tag Aside < aside
	def render
		<self>
			if params:document then <ElementAsideEditor route="/stores/:part/:document">
			elif params:document then <ElementAside route="/stores/:part/:document">

export tag Article < article

	def createNewFolder
		@count = 0 unless @count
		@count += 1

	def toggleNavigate
		@nav-active = !@nav-active

	def render
		<self>
			if params:document then <ElementHeaderEditor route="/stores/:part/:document">
			elif params:document then <ElementHeader route="/stores/:part/:document">
			else
				<h2>
					unless params:part then <span> "Store"
					else
						<span>
							<span.to-capitalize-first> params:part
					<dfn>
					<aside>
					<blockquote>
						if params:part then <kbd :tap.toggleNavigate> <svg:svg> <svg:use href="{ ISVG }#bars">
						<label>
							<input type="text" placeholder="Search { params:part or 'element store'}">
							<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			if params:document then <ElementArticleEditor route="/stores/:part/:document">
			elif params:document then <ElementArticle route="/stores/:part/:document">
			else
				<section.list-state>
					if params:part then <nav .active=@nav-active>
						<label>
							<input type="text" placeholder="Enter new folder name" required=true>
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

					<ul> for item in Array 20
						<li> <ItemFigure>
