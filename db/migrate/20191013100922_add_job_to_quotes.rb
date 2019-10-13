class AddJobToQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :quotes, :job, type: :uuid,foreign_key: true
  end
end
