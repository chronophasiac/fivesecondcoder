class SplitSchema < ActiveRecord::Base
  attr_accessible :name, :regex

  has_many :cards
end
