class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
    	t.string :title
    	t.string :composer
    	t.string :arranger
    	t.string :libretto
    	t.string :voice
    	t.string :accomp
    	t.string :genre
    	t.string :language
    	t.string :region
    	t.string :theme
    	t.string :curric
    	t.string :additional
    	t.integer :num_tot
    	t.integer :num_avail
    	t.string :res_type
    	t.string :link
    	t.string :pic
      t.timestamps null: false
	end
end
