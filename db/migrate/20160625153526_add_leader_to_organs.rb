class AddLeaderToOrgans < ActiveRecord::Migration
  def change
    add_column :organs, :is_leader, :integer, :default => 0
    add_column :members, :is_visible_leader, :integer, :default => 0
  end
end
