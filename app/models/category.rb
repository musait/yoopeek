class Category < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :join_categories
  has_many :subcategories, :through => :join_categories
  has_many :workers
  has_many :join_tags
  has_many :tags, through: :join_tags
  accepts_nested_attributes_for :subcategories

end
