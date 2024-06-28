class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :critics, through: :reviews, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  has_one_attached :main_image

  RATINGS = %w[G PG PG-13 R NC-17]

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  validates :released_on, :duration, presence: true

  validates :description, length: { minimum: 25 }

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validates :rating, inclusion: { in: RATINGS }

  validate :acceptable_image

  scope :released,
        -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming,
        -> { where("released_on > ?", Time.now).order("released_on desc") }
  scope :recent, ->(max = 5) { released.limit(max) }
  scope :hits,
        -> { where("total_gross >= ?", 300_000_000).order(total_gross: :desc) }
  scope :flops,
        -> { where("total_gross < ?", 225_000_000).order(total_gross: :asc) }
  scope :recently_added, -> { order(created_at: :desc).limit(3) }

  def average_stars
    reviews.average(:stars) || 0.0
  end

  def flop?
    if reviews.count > 50 && reviews.average(:stars) >= 4
      false
    else
      total_gross.blank? || total_gross < 225_000_000
    end
  end

  def to_param
    slug
  end

  private

  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size <= 1.megabyte
      errors.add(:main_image, "is too big")
    end

    acceptable_types = %w[image/png image/jpg]
    unless acceptable_types.include?(main_image.blob.content_type) {
             errors.add(:main_image, "must be a JPEG or PNG")
           }
    end
  end
end
