class ChangeColumnLatLngToDecimal < ActiveRecord::Migration[5.0]
  def change
    change_column :places, :latitude, :decimal, :precision => 15, :scale => 13
    change_column :places, :longitude, :decimal, :precision => 15, :scale => 13
  end
end
