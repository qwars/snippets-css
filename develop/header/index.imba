
import './index.styl'

export tag Sketch < header
	@classes = []

	def displayName
		@displayName or @displayName = application.profile and application.profile:displayName or application.profile:email.replace /(.+?)\@(.+)/, do "@{$2}"

	def signOut
		application.signOut.then do router.go '/'

	def render
		<self>
			<a route-to="/">
				<svg:svg> <svg:use href="{ ISVG }#logo-qwars">
				<dfn> 'Free from work'
			<nav>
				<a route-to="/projects"> "Projects"
				<a route-to="/templates"> "Templates"
				<a route-to="/widgets"> "Widgets"
				<s>
				<a route-to="/stores">
					<div>
						<a route-to="/stores/projects"> "Projects"
						<a route-to="/stores/templates"> "Templates"
						<a route-to="/stores/widgets"> "Widgets"
					<span> "Store"
			<aside>
				<a route-to="/office">
					if application.profile
						<span> application.profile:displayName or application.profile:email.replace /(.+?)\@(.+)/, do "@{$2}"
						<abbr> <img src=( application.profile:photoURL or "https://eightbitavatar.herokuapp.com/?id={application.profile:uid}&s=male&size=32" )>
				<kbd :tap.signOut> <svg:svg> <svg:use href="{ ISVG }#sign-out">