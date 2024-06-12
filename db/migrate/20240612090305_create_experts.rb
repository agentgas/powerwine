class CreateExperts < ActiveRecord::Migration[7.1]
  def up
    create_table :experts do |t|
      t.string :name, null: false
      t.string :email, index: { unique: true }, null: false

      t.timestamps
    end
  end

  def down
    drop_table :experts
  end
end
