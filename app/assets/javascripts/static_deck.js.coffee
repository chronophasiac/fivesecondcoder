# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	renderHTML = (codeSnippet) ->
		codeSnippet.forEach (line, lineIndex) ->
			htmlLine = ""
			line.forEach (token, tokenIndex) ->
				htmlLine += "<span id='#{lineIndex + 1} #{tokenIndex + 1}' class='code_snippet'>#{token}</span>"
			$('#code').append("<li>#{htmlLine}</li>")

	attachClickEvents = (answers) ->
		$('.code_snippet').click ->
			resp = $(@).attr('id').split(" ").map (idString) ->
				parseInt idString
			correctAnswer = false
			for answer in answers
				if resp[0] == answer.line && resp[1] == answer.substring
					correctAnswer = true
					alert "Correct!"
			alert "Try Again" unless correctAnswer

	startUp = (e) ->	
		e.preventDefault()
		$.getJSON '/cards/4/', (data) ->
			renderHTML(data.tokenized_code)
			attachClickEvents(data.answers)

	$("#start").click(startUp)
