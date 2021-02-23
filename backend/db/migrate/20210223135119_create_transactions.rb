class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :type
      t.string :nature
      t.boolean :signal
      t.float :value

      t.timestamps
    end
  end
end
