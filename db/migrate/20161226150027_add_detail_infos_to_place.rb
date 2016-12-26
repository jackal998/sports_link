class AddDetailInfosToPlace < ActiveRecord::Migration[5.0]
  def change
    add_column :places , :level, :float
    add_column :places , :popularity, :float
    add_column :places , :openhour, :string
    add_column :places , :contact, :string
    add_column :places , :fee, :string
    add_column :places , :facility, :string
  end
end
