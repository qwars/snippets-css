
import './index.styl'

export tag Article < section

	@classes = ['page-not-found']

	def render
		<self>
			<section>
				<em>
					<span> "Page not found "
					<a route-to="{params:path.replace /\w+$/, '#return'}"> "Go to parent"