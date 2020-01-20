class ChangesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_background, :string
    add_column :users, :recent_info, :string
  end
end
