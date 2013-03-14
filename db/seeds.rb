# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

defaultSchema = SplitSchema.create(name: 'Default', regex: '(\\W)|(\\s)', is_regex: true)

card = Card.create(task: 'Click on each squirrel.',
									 code: "function chase (squirrel) {\r\n  maple = new tree;\r\n  maple.residents.push(squirrel);\r\n  return maple;\r\n  }")
card.answers.create(line: 1, substring: 7)
card.answers.create(line: 3, substring: 11)

card = Card.create(task: 'Click the (implied) return statement.',
									 code: "\tdef tokenized_code\r\n\t\tcode_array = []\r\n\t\tself.split_lines.each { |line|\r\n\t\t\tline_array = []\r\n\t\t\tsplit_substrings(line).each { |substring|\r\n\t\t\t\tline_array.push(substring)\r\n\t\t\t}\r\n\t\t\tcode_array.push(line_array)\r\n\t\t}\r\n\t\tcode_array\r\n\tend")
card.answers.create(line: 10, substring: 5)

card = Card.create(task: "Click all statements that modify the initial value of 'score'.",
									 code: "\tinitializeSnippet = (answers) ->\r\n\t\tscore = 0\r\n\t\t$('div#score_window').html(\"Score: <span id='current_score'>\#{score}</span> / \#{answers.length}\")\r\n\t\t$('span.code_snippet').click ->\r\n\t\t\tresp = $(@).attr('id').split(\" \").map (idString) ->\r\n\t\t\t\tparseInt idString\r\n\t\t\tcorrectAnswer = false\r\n\t\t\tfor answer in answers\r\n\t\t\t\tif resp[0] == answer.line && resp[1] == answer.substring\r\n\t\t\t\t\tcorrectAnswer = true\r\n\t\t\tif correctAnswer\r\n\t\t\t\tscore++\r\n\t\t\t\t$(@).addClass('correct_answer')\r\n\t\t\telse\r\n\t\t\t\t$(@).addClass('wrong_answer')")
card.answers.create(line:12, substring: 9)
