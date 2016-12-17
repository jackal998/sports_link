class AddCharacteristicOfUsers1ToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events ,:characteristic_of_user, :string
  end
end
