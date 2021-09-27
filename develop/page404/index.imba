
import './index.styl'

export tag Article < section

	@classes = ['page-not-found']

	def render
		<self>
			<section>
				<em>
					<span> "Page not found "
					<a.not-active route-to="/{params:collection}/{ params:collection === 'stores' and  params:part or '' }"> "Go to parent"