class Recipe < ApplicationRecord
  has_many :bookmarks

  velidates :name, uniqueness: true, presence: true
  velidates :description, presence: true
  velidates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end
