class Category < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :join_categories
  has_many :subcategories, :through => :join_categories
  accepts_nested_attributes_for :subcategories
  
end
