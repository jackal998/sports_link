class AddOmniauthToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fb_uid, :string
    add_column :users, :fb_token, :string
    add_column :users, :fb_raw_data, :string
    add_column :users, :fb_name, :string
    add_column :users, :fb_avatar, :string

    add_index :users, :fb_uid
  end
end
