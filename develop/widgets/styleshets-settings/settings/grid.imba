
import Widget as InputUnits from  '../../editor-wysiwyg/input-units'

const IW = require '../icons-symbols.svg'

export tag Sketch < section
	@classes = []

	def toggleAlignSafe e
		console.log e.target

	def render
		<self>
			<span>
				<i> <svg:svg> <svg:use href="{ IW }#row-start">
				<InputUnits['1fr'] property="grid">
			<span>
				<i> <svg:svg> <svg:use href="{ IW }#col-start">
				<InputUnits['1fr'] property="grid">
			<kbd>
				<svg:svg> <svg:use href="{ IW }#justify-end-settings">
				<svg:svg :tap.toggleAlignSafe> <svg:use href="{ IW }#last-settings">

			<span>
				<i> <svg:svg> <svg:use href="{ IW }#row-end">
				<InputUnits['1fr'] property="grid">
			<span>
				<i> <svg:svg> <svg:use href="{ IW }#col-end">
				<InputUnits['1fr'] property="grid">
			<kbd>
				<svg:svg> <svg:use href="{ IW }#align-end-settings">
				<svg:svg :tap.toggleAlignSafe> <svg:use href="{ IW }#empty-settings">
