# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	#TODO implement new answer detection
	newAnswers = []
	awaitingEndOffset = false
	#TODO fix this
	startOffset = 0
	endOffset = 0
	$('.code_snippet').click ->
		if awaitingEndOffset
			endOffset = parseInt $(@).attr('id')
			awaitingEndOffset = false
			$.ajax
				type: 'post'
				url: "/cards/#{cardId}/answers"
				data: { answer: { start_offset: startOffset, end_offset: endOffset } }
				dataType: 'json'
				success: (json) ->
					$('div#answers ol:last-child').append("<li>Start Offset:#{startOffset} End Offset:#{endOffset}</li>")
		else
			startOffset = parseInt $(@).attr('id')
			awaitingEndOffset = true
