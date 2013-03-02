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

	def tokenized_code
		code_array = []
		self.split_lines.each { |line|
			line_array = []
			split_substrings(line).each { |substring|
				line_array.push(substring)
			}
			code_array.push(line_array)
		}
		code_array
	end

	def as_json(options = {})
		super(methods: :tokenized_code, except: :split_schema_id, include: :answers)
	end
end
