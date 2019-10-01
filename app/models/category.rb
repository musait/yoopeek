class Category < ApplicationRecord
  has_many :jobs
  has_many :under_categories
end
