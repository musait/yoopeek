class JoinProfessionSubcategory < ApplicationRecord
  belongs_to :profession
  belongs_to :subcategory
end
