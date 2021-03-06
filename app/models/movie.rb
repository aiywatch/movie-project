class Movie < ApplicationRecord
  has_many :reviews

  mount_uploader :poster_image_url, ImageUploader

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :poster_image_url,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  # scope :title, -> (title) { where("title LIKE ?", "%#{title}%") }
  # scope :director, -> (director) { where("director LIKE ?", "%#{director}%") }

  scope :search_word, -> (search) { where("title LIKE ? OR director LIKE ?", "%#{search}%", "%#{search}%") }
  scope :duration, -> (duration) { where("runtime_in_minutes #{duration}") unless duration.nil?  }


  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size unless reviews.empty?
  end

  protected
    def release_date_is_in_the_past
      if release_date.present?
        errors.add(:release_date, "should be in the past") if release_date > Date.today
      end
    end
end
