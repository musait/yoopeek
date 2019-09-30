class Company < ApplicationRecord
  belongs_to :worker, :class_name => "Worker", :foreign_key => "user_id"
end
