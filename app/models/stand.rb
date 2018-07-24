class Stand < ApplicationRecord
  has_many :stand_tags
  has_many :tags, :through => :stand_tags

  validates :area, :name, presence: true

  scope :select_by_tag, -> (tag_ids) {
    where(tags: {id: tag_ids})
  }

  def image_url
    frf_url = "http://www.fujirockfestival.com/news/"
    "#{frf_url}#{image}"
  end
end
