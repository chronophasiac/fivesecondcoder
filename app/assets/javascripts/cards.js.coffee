# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	highlightAnswer = (answer, classToAdd, classToRemove = false) ->
		answerSpans = [answer.start_offset..answer.end_offset]
		for answerSpan in answerSpans
			if classToRemove then $("span##{answerSpan}").removeClass(classToRemove)
			$("span##{answerSpan}").addClass(classToAdd)

	saveNewAnswer = (newAnswer) ->
		$.ajax
			type: 'post'
			url: "/cards/#{cardId}/answers"
			data: { answer: newAnswer }
			dataType: 'json'
			success: (json) ->
				cardAnswers.push newAnswer
				highlightAnswer(newAnswer, 'correct', 'pending_save')
				$('div#card_answers ol:last-child').append("<li>Start Offset:#{newAnswer.start_offset} End Offset:#{newAnswer.end_offset}</li>")

	if $('div#card_code').length
		newAnswers = []
		awaitingEndOffset = false
		for cardAnswer in cardAnswers
			highlightAnswer(cardAnswer, 'correct')
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
				allAnswers = cardAnswers.concat(newAnswers)
				for answer in allAnswers
					for existingOffset in [answer.start_offset..answer.end_offset]
						for newOffset in [startOffset..endOffset]
							if newOffset == existingOffset
								isNewAnswer = false
								$('div#overlap_error').removeClass('hidden')
				if isNewAnswer
					newAnswer = { start_offset: startOffset, end_offset: endOffset }
					highlightAnswer(newAnswer, 'pending_save')
					newAnswers.push newAnswer
					$('a#save_prompt').removeClass('hidden')
					$('div#overlap_error').addClass('hidden')
			else
				startOffset = parseInt $(@).attr('id')
				awaitingEndOffset = true

		$('a#save_prompt').click ->	
			for newAnswer in newAnswers
				saveNewAnswer(newAnswer)
			newAnswers = []
			$('a#save_prompt').addClass('hidden')
