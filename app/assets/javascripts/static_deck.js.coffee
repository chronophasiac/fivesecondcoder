# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->

	$("#start").click (e) ->
		e.preventDefault()
		loadCard()

	loadCard = ->
		$.getJSON '/cards/random/', (card) ->
			$('div#card').fadeOut ->
				initializeCard()
				renderCard(card)
				$('div#card').fadeIn ->
					interactifySnippet(card.answers)

	initializeCard = ->
		$('div#code_window').removeClass('hidden')
		$('#score_window').removeClass('score_complete')
		$('a#start').hide()
		$('ol#code').html('<ol></ol>')

	renderCard = (card) ->
			$('div#task').text(card.task)
			card.tokenized_code.forEach (line, lineIndex) ->
				htmlLine = ""
				line.forEach (token, tokenIndex) ->
					#replace tabs with double spaces (takes up less horizontal space)
					if token == "\t" then token = "  "
					htmlLine += "<span id='#{lineIndex + 1} #{tokenIndex + 1}' class='code_snippet'>#{token}</span>"
				$('ol#code').append("<li>#{htmlLine}</li>")

	interactifySnippet = (answers) ->
		score = 0
		$('div#score_window').html("Score: <span id='current_score'>#{score}</span> / #{answers.length}")
		$('span.code_snippet').click ->
			#parse the element id's into an array of integers
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
