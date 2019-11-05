class CreateCreditChangements < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_changements, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, foreign_key: true
      t.boolean :is_for_add, default: false
      t.float :quantity, default: 0
      t.belongs_to :credits_payment, type: :uuid, foreign_key: true
      t.belongs_to :subscription, type: :uuid, foreign_key: true
      t.belongs_to :room, type: :uuid, foreign_key: true
      t.integer :create_for, default: 0

      t.timestamps
    end
  end
end
