class Category < ApplicationRecord
  has_many :jobs, dependent: :destroy
  has_many :subcategories, dependent: :destroy
end
