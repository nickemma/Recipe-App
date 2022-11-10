class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods


  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
end
