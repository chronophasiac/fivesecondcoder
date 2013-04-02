# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	highlightAnswer = (answer, classToAdd, classToRemove = false) ->
		answerSpans = [answer.start_offset..answer.end_offset]
		for answerSpan in answerSpans
			if classToRemove then $("span##{answerSpan}").removeClass(classToRemove)
			$("span##{answerSpan}").addClass(classToAdd)

	isOverlap = (inputAnswer, answersPendingSave) ->
		for answer in cardAnswers.concat(answersPendingSave)
			for existingOffset in [answer.start_offset..answer.end_offset]
				for newOffset in [inputAnswer.start_offset..inputAnswer.end_offset]
					if newOffset == existingOffset
						return false
		return true
	
	saveAnswer = (answerPendingSave) ->
		$.ajax
			type: 'post'
			url: "/cards/#{cardId}/answers"
			data: { answer: answerPendingSave }
			dataType: 'json'
			success: (json) ->
				cardAnswers.push answerPendingSave
				highlightAnswer(answerPendingSave, 'correct', 'pending_save')
				$('div#card_answers ol:last-child').append("<li>Start Offset:#{answerPendingSave.start_offset} End Offset:#{answerPendingSave.end_offset}</li>")
				#Remove saved answer from the array of pending answers
				answersPendingSave.splice(answersPendingSave.indexOf(answerPendingSave), 1)

	if $('div#card_code').length
		answersPendingSave = []
		awaitingEndOffset = false
		inputAnswer = {}
		for cardAnswer in cardAnswers
			highlightAnswer(cardAnswer, 'correct')

		$('span.card_code_snippet').click ->
			#TODO allow removal of answers that are pending save
			$('div#start_prompt,div#end_prompt').toggleClass('hidden')
			if awaitingEndOffset
				inputAnswer.end_offset = parseInt $(@).attr('id')
				awaitingEndOffset = false
				#Swap start and end offsets if the selection was made right to left
				if inputAnswer.start_offset > inputAnswer.end_offset
					temp = inputAnswer.start_offset
					inputAnswer.start_offset = inputAnswer.end_offset
					inputAnswer.end_offset = temp
				if isOverlap(inputAnswer, answersPendingSave)
					highlightAnswer(inputAnswer, 'pending_save')
					answersPendingSave.push inputAnswer
					$('a#save_prompt').removeClass('hidden')
					$('div#overlap_error').addClass('hidden')
				else
					$('div#overlap_error').removeClass('hidden')
			else
				inputAnswer = { start_offset: parseInt $(@).attr('id') }
				awaitingEndOffset = true

		$('a#save_prompt').click ->	
			for answerPendingSave in answersPendingSave
				saveAnswer(answerPendingSave)
			answersPendingSave = []
			$('a#save_prompt').addClass('hidden')
