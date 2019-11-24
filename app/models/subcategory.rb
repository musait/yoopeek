class Subcategory < ApplicationRecord
  has_many :join_categories
  has_many :categories, :through => :join_categories
  has_many :join_profession_subcategories
  has_many :professions, :through => :join_profession_subcategories
  has_many :jobs
end
