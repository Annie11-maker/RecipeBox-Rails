class Category < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :recipes, through: :bookmarks

  velidates :name, uniqueness: true, presence: true
end
