class AddLibraryToResources < ActiveRecord::Migration
  def change
    add_column :resources, :library, :string
  end
end
