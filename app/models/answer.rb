class Answer < ActiveRecord::Base
  attr_accessible :card_id, :line, :substring

  belongs_to :card
  
  validates_presence_of :card_id
end
