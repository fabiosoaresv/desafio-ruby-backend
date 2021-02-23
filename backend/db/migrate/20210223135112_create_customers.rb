class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :number_card
      t.string :cpf
      t.timestamps
    end
  end
end
