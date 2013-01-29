class Card < ActiveRecord::Base
  attr_accessible :code, :task

  validates_presence_of :code, :task
end
