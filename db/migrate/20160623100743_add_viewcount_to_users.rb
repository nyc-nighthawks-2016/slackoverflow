class AddViewcountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :view_count, :integer, default: 0
  end
end
