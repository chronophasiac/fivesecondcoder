# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	clearSnippit = ->
		$('#code').html('<ol></ol>')

	renderSnippet = (codeSnippet) ->
		codeSnippet.forEach (line, lineIndex) ->
			htmlLine = ""
			line.forEach (token, tokenIndex) ->
				htmlLine += "<span id='#{lineIndex + 1} #{tokenIndex + 1}' class='code_snippet'>#{token}</span>"
			$('#code').append("<li>#{htmlLine}</li>")

	initializeSnippet = (answers) ->
		score = 0
		$('#score_window').html("Score: <span id='current_score'>#{score}</span> / #{answers.length}")
		$('.code_snippet').click ->
			resp = $(@).attr('id').split(" ").map (idString) ->
				parseInt idString
			correctAnswer = false
			for answer in answers
				if resp[0] == answer.line && resp[1] == answer.substring
					correctAnswer = true
			if correctAnswer
				score++
				$(@).addClass('correct_answer')
			else
				$(@).addClass('wrong_answer')
			$('span#current_score').text(score)
			if score == answers.length
				$('#score_window').addClass('score_complete')
				setTimeout(loadCard,500)

	loadCard = ->
		$.getJSON '/cards/random/', (card) ->
			$('div#task').text(card.task)
			clearSnippit()
			renderSnippet(card.tokenized_code)
			initializeSnippet(card.answers)

	$("#start").click (e) ->
		e.preventDefault()
		loadCard()
