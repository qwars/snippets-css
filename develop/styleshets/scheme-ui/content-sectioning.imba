
export tag Sketch < article

	@classes = ['content-sectioning']

	def toggleOpen e
		e.target.parent.open = !e.target.parent.open

	def render
		<self>
			<h2>
				<span> "Content sectioning"
				<dfn> "Content sectioning elements allow you to organize the document content into logical pieces. Use the sectioning elements to create a broad outline for your page content, including header and footer navigation, and heading elements to identify sections of content."
			<section>
				<hr data-step=1 open=true> <legend :tap.toggleOpen> "Headers"
				<section>
					<div>
						<h3> "Tag: H1"
						<h1.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside>
								<kbd> <svg:svg> <svg:use href="{ ISVG }#ban">
								<span> "ASIDE"
						<p>
					<div>
						<h3> "Tag: H2"
						<h2.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside> 
								<kbd> <svg:svg> <svg:use href="{ ISVG }#ban">
								<span> "ASIDE"
						<p>
					<div>
						<h3> "Tag: H3"
						<h3.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside> "ASIDE"
						<p>
					<div>
						<h3> "Tag: H4"
						<h4.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside> "ASIDE"
						<p>
					<div>
						<h3> "Tag: H5"
						<h5.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside> "ASIDE"
						<p>
					<div>
						<h3> "Tag: H6"
						<h6.sketch>
							<span> "SPAN"
							<dfn> "DFN"
							<aside> "ASIDE"
						<p>
				<hr data-step=2 > <legend :tap.toggleOpen> "Structure page"
				<section>
					<div>
						<h3> "Tag: HEADER"
						<header.sketch>
							<a> "A"
							<nav> "NAV"
							<aside> "ASIDE"
						<p>
					<div>
						<h3> "Tag: MAIN"
						<main.sketch>
							<nav> "NAV"
							<article> "ARTICLE"
							<aside> "ASIDE"
						<p>
					<div>
						<h3> "Tag: FOOTER"
						<footer.sketch>
							<address> "ADDRESS"
							<nav> "NAV"
							<aside> "ASIDE"
						<p>
				<hr data-step=3> <legend :tap.toggleOpen> "Navigations page"
				<section>