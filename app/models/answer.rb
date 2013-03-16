class Answer < ActiveRecord::Base
	attr_accessible :card_id, :start_offset, :end_offset
  belongs_to :card
	validates_presence_of :card_id, :start_offset, :end_offset
	validates :start_offset, :numericality => { :only_integer => true }
	validates :end_offset, :numericality => { :only_integer => true, :greater_than_or_equal_to => :start_offset }
end
