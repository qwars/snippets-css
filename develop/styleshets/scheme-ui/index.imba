
import './index.styl'

import Sketch as SchemeUIColors from './colors'
import Sketch as SchemeUISemantics from './semantics'
import Sketch as SchemeUIForms from './forms'
import Sketch as SchemeUIContentSectioning from './content-sectioning'
import Sketch as SchemeUITextContent from './text-content'
import Sketch as SchemeUIInlineTextSemantics from './inline-text-semantics'
import Sketch as SchemeUIImageAndMultimedia from './image-and-multimedia'
import Sketch as SchemeUIDemarcatingEdits from './demarcating-edits'
import Sketch as SchemeUITableContent from './table-content'
import Sketch as SchemeUIInteractiveElements from './interactive-elements'

tag SchemeUIMain < article
	def render
		<self>
			<h2>
				<span> "Generators & Snippets"
				<dfn>
				<aside>

export tag Sketch
	@classes = ['scheme-ui']

	def render
		<self>
			<nav>
				<a route-to="/-" .not-active=( !router.location.path.match /^\/-\/*$/ )> "Generators & Snippets"
				<a route-to="/-/colors"> "Colors"
				<a route-to="/-/semantics"> "Semantics in HTML"
				<a route-to="/-/forms"> "Forms"
				<a route-to="/-/content-sectioning"> "Content sectioning"
				<a route-to="/-/text-content"> "Text content"
				<a route-to="/-/inline-text-semantics"> "Inline text semantics"
				<a route-to="/-/image-and-multimedia"> "Image and multimedia"
				<a route-to="/-/demarcating-edits"> "Demarcating edits"
				<a route-to="/-/table-content"> "Table content"
				<a route-to="/-/interactive-elements"> "Interactive elements"

			<SchemeUIMain route="/-/*$">
			<SchemeUIColors route="/-/colors/*:document*">
			<SchemeUISemantics route="/-/semantics/*:document*">
			<SchemeUIForms route="/-/forms/*:document*">
			<SchemeUIContentSectioning route="/-/content-sectioning/*:document*">
			<SchemeUITextContent route="/-/text-content/*:document*">
			<SchemeUIInlineTextSemantics route="/-/inline-text-semantics/*:document*">
			<SchemeUIImageAndMultimedia route="/-/image-and-multimedia/*:document*">
			<SchemeUIDemarcatingEdits route="/-/demarcating-edits/*:document*">
			<SchemeUITableContent route="/-/table-content/*:document*">
			<SchemeUIInteractiveElements route="/-/interactive-elements/*:document*">
