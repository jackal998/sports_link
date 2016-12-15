class AddColumnToEvent < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :end_at, :datetime
  end
end
