class AddMaterialsToItemsTable < ActiveRecord::Migration
  def change
  	add_column :items, :materials, :string
  end
end
