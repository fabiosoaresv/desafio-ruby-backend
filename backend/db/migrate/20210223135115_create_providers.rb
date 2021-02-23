class CreateProviders < ActiveRecord::Migration[6.1]
  def change
    create_table :providers do |t|
      t.string :name_owner
      t.string :name_provider
      t.timestamps
    end
  end
end
