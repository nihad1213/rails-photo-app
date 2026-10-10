class Photo < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :image, presence: true
  validate :image_must_be_an_image

  private

  def image_must_be_an_image
    return unless image.attached?
    errors.add(:image, "must be a JPG, PNG, GIF or WebP") unless
      image.content_type.in?(%w[image/jpeg image/png image/gif image/webp])
  end
end
