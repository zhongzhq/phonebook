class AddTimestampsToApply < ActiveRecord::Migration
  def change
    change_table(:applies) { |t| t.timestamps }
  end
end
