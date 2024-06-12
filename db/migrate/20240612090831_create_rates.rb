class CreateRates < ActiveRecord::Migration[7.1]
  def up
    create_table :rates do |t|
      t.integer :rate, null: false

      t.references :wine, null: false, foreign_key: true
      t.references :expert, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :rates
  end
end
