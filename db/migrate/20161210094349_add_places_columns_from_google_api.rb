class AddPlacesColumnsFromGoogleApi < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :place_id, :string
    add_column :places, :formatted_address, :string
    add_column :places, :long_name, :string
    add_column :places, :address_components, :string
  end
end
