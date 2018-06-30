class Stand < ApplicationRecord
  validates :area, :name, presence: true
end
