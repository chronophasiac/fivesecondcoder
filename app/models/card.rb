class Card < ActiveRecord::Base
  attr_accessible :code, :task, :split_schema_id
  
  has_many :answers
  
  belongs_to :split_schema

  validates_presence_of :code, :task

	def split_lines
		self.code.split(/\r\n/)	
	end

	def split_substrings(line)
		line.split(/#{self.split_schema.regex}/)
	end
end
