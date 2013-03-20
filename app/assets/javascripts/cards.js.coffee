# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	highlightCardAnswers = (answers) ->
		for answer in answers
			answerSpans = [answer[0]..answer[1]]
			for spanID in answerSpans
				$("span##{spanID}").addClass('correct')

	if $('div#card_code').length
		newAnswers = []
		awaitingEndOffset = false
		startOffset = 0
		endOffset = 0
		highlightCardAnswers(cardAnswers)

		$('span.card_code_snippet').click ->
			if awaitingEndOffset
				endOffset = parseInt $(@).attr('id')
				awaitingEndOffset = false
				newAnswer = { start_offset: startOffset, end_offset: endOffset }
				fresh = true
				for cardAnswer in cardAnswers
					for existingOffset in [cardAnswer[0]..cardAnswer[1]]
						for newOffset in [startOffset..endOffset]
							if newOffset == existingOffset then fresh = false
				if fresh
					#TODO buffer newAnswers and push to server on user command
					newAnswers.push newAnswer
					$.ajax
						type: 'post'
						url: "/cards/#{cardId}/answers"
						data: { answer: newAnswer }
						dataType: 'json'
						success: (json) ->
							cardAnswers.push [startOffset,endOffset]
							highlightCardAnswers(cardAnswers)
							$('div#card_answers ol:last-child').append("<li>Start Offset:#{startOffset} End Offset:#{endOffset}</li>")
			else
				startOffset = parseInt $(@).attr('id')
				awaitingEndOffset = true

