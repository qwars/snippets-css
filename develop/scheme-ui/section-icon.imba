
export tag Sketch < section

	@classes = [];

	def setup
		window.fetch( "{ ISVG }" ).then do|response| response:ok and response.text
			.then do|resource|
				@icons = for item in  DOMParser.new.parseFromString( resource, "text/html" ).querySelectorAll( '[id]' )
					item:id
				render

	def render
		<self>
			unless @icons then <.loading>
			else <dl> for item in @icons
				<dt> <abbr> <svg:svg> <svg:use href="{ ISVG }#{ item }">
				<dd>
					<span> item
					<code text="<svg:svg> <svg:use href=\"\{ ISVG \}#{ item }\">">