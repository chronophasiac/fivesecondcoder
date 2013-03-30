# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	highlightCardAnswers = (answers) ->
		for answer in answers
			answerSpans = [answer[0]..answer[1]]
			for spanID in answerSpans
				$("span##{spanID}").addClass('correct')

	highlightPendingAnswer = (answer) ->
		answerSpans = [answer.start_offset..answer.end_offset]
		for spanID in answerSpans
			$("span##{spanID}").addClass('pending_save')

	changeHighlight = (answer) ->
		answerSpans = [answer.start_offset..answer.end_offset]
		for spanID in answerSpans
			$("span##{spanID}").removeClass('pending_save')
			$("span##{spanID}").addClass('correct')

	saveNewAnswer = (newAnswer) ->
		$.ajax
			type: 'post'
			url: "/cards/#{cardId}/answers"
			data: { answer: newAnswer }
			dataType: 'json'
			success: (json) ->
				cardAnswers.push [newAnswer.start_offset, newAnswer.end_offset]
				changeHighlight(newAnswer)
				$('div#card_answers ol:last-child').append("<li>Start Offset:#{newAnswer.start_offset} End Offset:#{newAnswer.end_offset}</li>")

	if $('div#card_code').length
		newAnswers = []
		awaitingEndOffset = false
		highlightCardAnswers(cardAnswers)
		#TODO fix this, shouldn't have to init here
		startOffset = 0
		endOffset = 0

		$('span.card_code_snippet').click ->
			#TODO allow removal of answers that are pending save
			$('div#start_prompt,div#end_prompt').toggleClass('hidden')
			if awaitingEndOffset
				endOffset = parseInt $(@).attr('id')
				awaitingEndOffset = false
				isNewAnswer = true
				#TODO fix new answer detection
				allAnswers = cardAnswers.concat(newAnswers)
				for answer in allAnswers
					for existingOffset in [answer[0]..answer[1]]
						for newOffset in [startOffset..endOffset]
							if newOffset == existingOffset then isNewAnswer = false
				if isNewAnswer
					newAnswer = { start_offset: startOffset, end_offset: endOffset }
					highlightPendingAnswer(newAnswer)
					newAnswers.push newAnswer
					$('a#save_prompt').removeClass('hidden')
			else
				startOffset = parseInt $(@).attr('id')
				awaitingEndOffset = true

		$('a#save_prompt').click ->	
			for newAnswer in newAnswers
				saveNewAnswer(newAnswer)
			newAnswers = []
			$('a#save_prompt').addClass('hidden')
