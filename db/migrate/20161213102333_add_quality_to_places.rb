class AddQualityToPlaces < ActiveRecord::Migration[5.0]
  def change
  	add_column :places , :quality, :float
  end
end
