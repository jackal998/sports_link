class ChangeLngLatPrecisionTo17151714 < ActiveRecord::Migration[5.0]
  def change
    change_column :places, :latitude, :decimal, :precision => 17, :scale => 15
    change_column :places, :longitude, :decimal, :precision => 17, :scale => 14
  end
end
