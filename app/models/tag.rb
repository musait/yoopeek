class Tag < ApplicationRecord
  has_many :join_tags
  has_many :categories, through: :join_tags



  has_many :join_tag_workers
  has_many :workers, through: :join_tag_workers
end
