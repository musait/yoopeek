class AddJoinTagWorker < ActiveRecord::Migration[5.2]
  def change
    create_table :join_tag_workers, id: :uuid do |t|
      t.belongs_to :tag, type: :uuid
      t.belongs_to :worker, type: :uuid
      t.timestamps
    end
  end
end
