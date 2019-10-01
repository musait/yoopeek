class AddUserToJobs < ActiveRecord::Migration[5.2]
  def change
    add_reference :jobs, :user,type: :uuid, foreign_key: true
  end
end
