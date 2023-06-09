class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  
  validates :image, presence: true
  validates :text, presence: true
  
  def get_image
    if image.attached?
      image
    end
  end
end
