class ChangesToTopics < ActiveRecord::Migration[5.2]
  def change
    add_column :topics, :title, :string
    add_column :topics, :parking_info, :string
    add_column :topics, :restaurant_info, :string
  end
end
