class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :type_transaction
      t.string :nature
      t.boolean :signal
      t.float :value
      t.belongs_to :customer
      t.belongs_to :provider
      t.timestamps
    end
  end
end
