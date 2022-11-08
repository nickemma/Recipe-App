class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :recipes, through: :recipe_foods

  validates :name, presence: true
  validates :measurement_unit, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :user_id, presence: true
end
