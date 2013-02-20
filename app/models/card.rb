class Card < ActiveRecord::Base
  attr_accessible :code, :task, :split_schema_id
  
  has_many :answers, dependent: :destroy
  
  belongs_to :split_schema

  validates_presence_of :code, :task, :split_schema_id
  
  after_initialize :init

  def init
  	self.split_schema ||= SplitSchema.default.first
  end

	def split_lines
		self.code.split(/\r\n/)	
	end

	def split_substrings(line)
		self.split_schema.is_regex ? line.split(/#{self.split_schema.regex}/) : [line]
	end
end
