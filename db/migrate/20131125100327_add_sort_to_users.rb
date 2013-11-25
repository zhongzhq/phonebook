class AddSortToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sort, :integer, :default => 0
  end
end
