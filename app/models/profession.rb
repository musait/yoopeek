class Profession < ApplicationRecord
  has_many :workers
  has_many :join_profession_subcategories
  has_many :subcategories, :through => :join_profession_subcategories
end
