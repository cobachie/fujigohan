class Stand < ApplicationRecord
  validates :area, :name, presence: true

  def image_url
    frf_url = "http://www.fujirockfestival.com/news/"
    "#{frf_url}#{image}"
  end
end
