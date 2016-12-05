class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :sport_name
      t.integer :place_id
      t.integer :user_id
      t.datetime :start_at

      t.timestamps
    end
  end
end
