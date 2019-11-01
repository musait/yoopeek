class Tag < ApplicationRecord
  has_many :join_tags
  has_many :categories, through: :join_tags
  has_many :workers, through: :categories
end
