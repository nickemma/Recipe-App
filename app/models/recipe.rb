class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :serves, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :ingredients, presence: true
  validates :method, presence: true
  validates :description, presence: true
  validates :user_id, presence: true

  def self.search(search)
    where('name LIKE ?', "%#{search}%")
  end

  def self.search_by_ingredients(search)
    where('ingredients LIKE ?', "%#{search}%")
  end

  def self.search_by_method(search)
    where('method LIKE ?', "%#{search}%")
  end
end
