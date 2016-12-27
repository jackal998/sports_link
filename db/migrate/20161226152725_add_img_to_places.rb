class AddImgToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places , :img, :string
  end
end
