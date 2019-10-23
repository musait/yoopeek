class Subcategory < ApplicationRecord
  has_many :join_categories
  has_many :categories, :through => :join_categories
  has_many :jobs
end
