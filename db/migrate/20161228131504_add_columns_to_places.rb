class AddColumnsToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places , :restroom, :boolean, default: false
    add_column :places , :drink, :boolean, default: false
    add_column :places , :parking, :boolean, default: false

    add_column :places , :light, :boolean, default: false
    add_column :places , :courts, :integer, default: 0
    add_column :places , :basket, :integer, default: 0
  end
end
