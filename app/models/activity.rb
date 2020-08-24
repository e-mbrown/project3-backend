class Activity < ApplicationRecord
  has_many :comments

  validates_presence_of :name
end
