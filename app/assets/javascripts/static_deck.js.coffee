# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	renderSnippet = (card) ->
		$('div#card').fadeOut ->
			$('div#code_window').removeClass('hidden')
			$('#score_window').removeClass('score_complete')
			$('a#start').hide()
			$('div#task').text(card.task)
			$('ol#code').html('<ol></ol>')
			card.tokenized_code.forEach (line, lineIndex) ->
				htmlLine = ""
				line.forEach (token, tokenIndex) ->
					htmlLine += "<span id='#{lineIndex + 1} #{tokenIndex + 1}' class='code_snippet'>#{token}</span>"
				$('ol#code').append("<li>#{htmlLine}</li>")
			$('div#card').fadeIn ->
				initializeSnippet(card.answers)

	initializeSnippet = (answers) ->
		score = 0
		$('div#score_window').html("Score: <span id='current_score'>#{score}</span> / #{answers.length}")
		$('span.code_snippet').click ->
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
			renderSnippet(card)

	$("#start").click (e) ->
		e.preventDefault()
		loadCard()
