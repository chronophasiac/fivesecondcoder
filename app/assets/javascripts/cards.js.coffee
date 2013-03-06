# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	newAnswers = []
	$('.code_snippet').click ->
		clickedSubstring = $(@).attr('id').split(" ").map (idString) ->
			parseInt idString
		$.ajax
			type: 'post'
			url: "/cards/#{cardId}/answers"
			data: { answer: { line: clickedSubstring[0], substring: clickedSubstring[1] } }
			dataType: 'json'
			success: (json) ->
				$('div#answers ol:last-child').append("<li>Line:#{clickedSubstring[0]} Substring:#{clickedSubstring[1]}</li>")
