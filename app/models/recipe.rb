class Recipe < ApplicationRecord
  has_many :bookmarks, dependent: :destroy

  validates :name, uniqueness: true, presence: true
  validates :description, presence: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
