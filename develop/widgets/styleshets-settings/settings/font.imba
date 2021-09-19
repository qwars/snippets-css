
import Widget as InputUnits from  '../../editor-wysiwyg/input-units'
import Widget as Details from  '../../details-tooltype'

const IW = require '../icons-symbols.svg'

export tag Sketch < section
	@classes = []
	def render
		<self>
			<span>
				<i> <svg:svg> <svg:use href="{ IW }#font-size">
				<InputUnits['10px']>
			<span>
				<i> <svg:svg> <svg:use href="{ IW }#line-height">
				<InputUnits['10px']>
			<Details>
				<summary>
					<kbd> <svg:svg> <svg:use href="{ IW }#font-weight">
					<span css:fontWeight="lighter"> 'lighter'
				<s> <ol>
					<li> 'normal'
					<li> 'bold'
					<li> 'lighter'
					<li> 'bolder'
					for item, idx in Array 9
						<li css:fontWeight=(( idx + 1 ) * 100)> ( idx + 1 ) * 100
