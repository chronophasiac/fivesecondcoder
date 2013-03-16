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
		offset = 0
		card.tokenized_code.forEach (line, lineIndex) ->
			htmlLine = ""
			line.forEach (token, tokenIndex) ->
				#replace tabs with double spaces (takes up less horizontal space)
				if token == "\t" then token = "  "
				htmlLine += "<span id='#{offset}' class='code_snippet'>#{token}</span>"
				offset++
			$('ol#code').append("<li>#{htmlLine}</li>")
		$('div#score_window').html("Score: <span id='current_score'>0</span> / #{card.answers.length}")

	interactifySnippet = (answers) ->
		$('span.code_snippet').click ->
			#parse the element id's into an array of integers
			resp = parseInt $(@).attr('id')
			correctAnswer = false
			for answer in answers
				if resp >= answer.start_offset && resp <= answer.end_offset
					correctAnswer = true
			if correctAnswer
				score = parseInt $('span#current_score').text()
				score++
				$('span#current_score').text(score)
				$(@).addClass('correct_answer')
			else
				$(@).addClass('wrong_answer')
			if score == answers.length
				$('#score_window').addClass('score_complete')
				setTimeout(loadCard,500)
