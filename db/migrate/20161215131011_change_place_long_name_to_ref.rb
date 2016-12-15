class ChangePlaceLongNameToRef < ActiveRecord::Migration[5.0]
  def change
    rename_column :places, :long_name, :reference
    change_column :places, :reference, :text
  end
end
