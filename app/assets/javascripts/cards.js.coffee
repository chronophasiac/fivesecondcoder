# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$('.code_snippet').click ->
		resp = $(@).attr('id').split(" ").map (idString) ->
			parseInt idString
		correctAnswer = false
		for answer in answers
			if resp[0] == answer[0] && resp[1] == answer[1]
				correctAnswer = true
				alert "Correct!"
		alert "Try Again" unless correctAnswer
