# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	startUp = (e) ->	
		e.preventDefault()
		$.getJSON '/cards/4', (data) ->
			lines = data.split_lines
			$('body').append(lines[0])
	$("#start").click(startUp)
