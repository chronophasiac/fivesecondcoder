class OverlapValidator < ActiveModel::Validator
	def validate(record)
		record.card.answers.each { |answer|
			(answer.start_offset..answer.end_offset).each { |existing_offset|
				(record.start_offset..record.end_offset).each { |validating_offset|
					if existing_offset == validating_offset
						record.errors[:base] << "Answers cannot overlap"
					end
				}
			}
		}
	end
end

class Answer < ActiveRecord::Base
	include ActiveModel::Validations
	attr_accessible :card_id, :start_offset, :end_offset
  belongs_to :card
	validates_presence_of :card_id, :start_offset, :end_offset
	validates :start_offset, :numericality => { :only_integer => true }
	validates :end_offset, :numericality => { :only_integer => true, :greater_than_or_equal_to => :start_offset }
	validates_with OverlapValidator
end

