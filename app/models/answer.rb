class Answer < ActiveRecord::Base
  attr_accessible :card_id, :line, :substring

  belongs_to :card
end
