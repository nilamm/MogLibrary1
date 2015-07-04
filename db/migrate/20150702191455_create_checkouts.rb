class CreateCheckouts < ActiveRecord::Migration
  def change
    create_table :checkouts do |t|
      t.integer :num_checked
      t.string :notes
      t.references :user
      t.references :resource

      t.timestamps null: false
    end
  end
end
