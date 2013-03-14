class SplitSchema < ActiveRecord::Base
  attr_accessible :name, :regex, :is_regex
  
  validates_presence_of :name

  has_many :cards

  scope :default, where("name = 'Default'")
end
