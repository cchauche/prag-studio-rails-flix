class Genre < ApplicationRecord
  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations

  validates :name, uniqueness: {case_sensitive: false}, presence: true
end
