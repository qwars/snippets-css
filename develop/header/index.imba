
import './index.styl'

export tag Sketch < header
	@classes = []

	def displayName
		@displayName or @displayName = application.profile and application.profile:displayName or application.profile:email.replace /(.+?)\@(.+)/, do "@{$2}"

	def render
		<self>
			<a route-to="/">
				<svg:svg> <svg:use href="{ ISVG }#logo-qwars">
				<dfn> 'Free from work'
			<nav>
				<a route-to="/projects"> "Projects"
				<a route-to="/templates"> "Templates"
				<a route-to="/widgets"> "Widgets"
				<a route-to="/store">
					<div>
						<a route-to="/store/projects"> "Projects"
						<a route-to="/store/templates"> "Templates"
						<a route-to="/store/widgets"> "Widgets"
					<span> "Store"
			<aside>
				<a route-to="/office">
					if application.profile
						<span> application.profile:displayName or application.profile:email.replace /(.+?)\@(.+)/, do "@{$2}"
						<abbr> <img src=( application.profile:photoURL or "https://eightbitavatar.herokuapp.com/?id={application.profile:uid}&s=male&size=32" )>
				<kbd> <svg:svg> <svg:use href="{ ISVG }#sign-out">