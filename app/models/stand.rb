class Stand < ApplicationRecord
  has_many :stand_tags
  has_many :tags, :through => :stand_tags

  validates :area, :name, presence: true

  def image_url
    frf_url = "http://www.fujirockfestival.com/news/"
    "#{frf_url}#{image}"
  end
end
