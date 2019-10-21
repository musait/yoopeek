class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications,id: :uuid do |t|
      t.string :message
      t.string :created_for
      t.datetime :viewed_at
      t.belongs_to :quote, type: :uuid, foreign_key: true
      t.belongs_to :job, type: :uuid, foreign_key: true
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.belongs_to :room_message, type: :uuid, foreign_key: true
      t.belongs_to :review, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
