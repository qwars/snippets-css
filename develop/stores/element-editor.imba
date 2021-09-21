
import Widget as CaruselImages from '../widgets/carusel-images'

const dataimages = []

export tag Header < h2
	def render
		<self>
			<span>
				<kbd route="/stores/widgets"> <svg:svg> <svg:use href="{ ISVG }#icon">
				<span contenteditable=true data-placeholder="Enter name { params:part }">
			<aside>
				<button> "Save changes"

export tag Navigation < section
	def render
		<self>

export tag Aside < section
	def render
		<self>

export tag Article < section
	@classes = ['store-editor']

	def uploadImage e
		console.log e.data

	def render
		<self>
			<section>
				<CaruselImages :upload.uploadImage>
				<h4> <dfn> "Description"
				<section>
				<h4> <dfn> "What’s new v.3.0"
				<section>
				<a route-to="#View-all-version"> "View all version"
				<h4> <dfn> "Tags"
				<section>

			<aside>
				<figure>
				<h4> <dfn> "Published"
				<section>
				<h4> <dfn> "Price"
				<section>
				<button> "Unpublish"
				<hr>
				<h4> <dfn> "Available"
				<section>
				<h4> <dfn> "Price"
				<button> "Update"
				<section>
				<h4>
					<aside>
					<dfn> "Available only selected users"
				<section>
