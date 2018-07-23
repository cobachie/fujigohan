class Tag < ApplicationRecord
  has_many :stand_tags
  has_many :stands, :through => :stand_tags
end
