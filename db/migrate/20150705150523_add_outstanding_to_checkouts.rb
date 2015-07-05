class AddOutstandingToCheckouts < ActiveRecord::Migration
  def change
    add_column :checkouts, :outstanding, :integer
  end
end
