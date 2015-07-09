class AddResourceToFavorite < ActiveRecord::Migration
  def change
    add_reference :favorites, :resource, index: true, foreign_key: true
  end
end
