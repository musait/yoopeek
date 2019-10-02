class Category < ApplicationRecord
  has_many :jobs
  has_many :subcategories
end
