class CreateWines < ActiveRecord::Migration[7.1]
  def up
    create_table :wines do |t|
      t.string :name, null: false
      t.string :producer, null: false
      t.integer :year, null: false
      t.float :price, null: false
      t.float :evaluation, index: true

      t.timestamps
    end
  end

  def down
    drop_table :wines
  end
end
