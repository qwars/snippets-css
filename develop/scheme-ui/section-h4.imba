
export tag Sketch < section
	@classes = []
	def render
		<self>
			<b>
				"Атрибут - "
				<samp> <q> "contenteditable"
			<p>
			<b>
				"Teг - "
				<samp> <q> "LABEL > INPUT"
			<p>
			<b>
				"Teг - "
				<samp> <q> "LABEL > TEXTAREA"
			<p>
				<div>
					"Элемент <input> создает большинство полей формы. Атрибуты элемента отличаются в зависимости от типа поля, для создания которого используется этот элемент."
					<blockquote>
						<label> <input placeholder="This is 'placeholder'">
						<label> <input placeholder="This is 'readonly'" readOnly=true>
						<label> <input placeholder="This is 'required'" required=true>
						<label> <input type="number" placeholder="This is 'invalid-test' enter > 100" max=100 value="101" >
			<b>
				"Teг - "
				<samp> <q> "DETAILS"
				" :: как всплывающая область"
			<p>
			<b>
				"Тег - "
				<samp> <q> "BUTTON"
			<p>
				<div>
					"Элемент <button>...</button> создает кликабельные кнопки. В отличие от кнопок, созданных <input> (<input type='submit'></input>, <input type='image'>, <input type='reset'>, <input type='button'>), внутрь элемента <button> можно поместить контент — текст или изображение."
					<blockquote>
						<button> "Text content"

			<b>
				"Тег - "
				<samp> <q> "DEL"
			<p>
			<b>
				"Тег - "
				<samp> <q> "INS"
			<p>
			<b>
				"Тег - "
				<samp> <q> "KBD"
			<p>
			<b>
				"Теги - "
				<samp> <q> "MAP, AREA"
			<p>