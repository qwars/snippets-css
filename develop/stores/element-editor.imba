
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
				<section contenteditable=true data-placeholder="Enter description for { params:part }">
				<h4> <dfn> "What’s new v.3.0"
				<section>
					<section contenteditable=true data-placeholder="Enter description for version { params:part }">
					<a route-to="#View-all-version"> "View all version"
				<h4> <dfn> "Tags"
				<section.tags-settings>
					for item in Array 6
						<span>
							<span> "Name"
							<del>
					<span contenteditable=true data-placeholder="Enter tag name for { params:part }" :keydown.enter.prevent.createNewTag>

			<aside> <section>
				<label css:backgroundImage="none">
					<input type="file">
					<p>
						<kbd> <svg:svg> <svg:use href="{ ISVG }#image">
						<em> "Upload image"
				<section>
					<h4> <dfn> "Published"
					"Emp"
				<section>
					<h4> <dfn> "Price"
					<label>
						<output@hp> @price.value or '0.00'
						<input@price type="number"  placeholder="0.00" min=0 step="0.01" css:width=@hp.dom:clientWidth>
						<u> "$"
					<span> "per month"
				<button.error> "Unpublish"
				<hr>
				<h4> <dfn> "Available"
				<section>
					<h4> <dfn> "Price"
					<label>
						<output@hps> @prices.value or '0.00'
						<input@prices type="number"  placeholder="0.00" min=0 step="0.01" css:width=@hps.dom:clientWidth>
						<u> "$"
					<span> "per month"

				<button> "Update"
				<section>
				<h4>
					<aside>
					<dfn> "Available only selected users"
				<section>
