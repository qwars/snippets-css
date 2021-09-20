
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

export tag Aside < aside
	def render
		<self>
			console.log 'aside'

export tag Article < article

	def createNewFolder
		@count = 0 unless @count
		@count += 1

	def toggleNavigate
		@nav-active = !@nav-active

	def render
		<self>
			<h2>
				unless params:document then <span> "Store"
				else
					<span>
						<span.to-capitalize-first> params:document
				<dfn>
				<aside>
				<blockquote>
					if params:document then <kbd :tap.toggleNavigate> <svg:svg> <svg:use href="{ ISVG }#bars">
					<label>
						<input type="text" placeholder="Search { params:document or 'element store'}">
						<i :tap.addSearchTags> <svg:svg> <svg:use href="{ ISVG }#search-plus">
			<section.list-state>
				if params:document then <nav .active=@nav-active>
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
