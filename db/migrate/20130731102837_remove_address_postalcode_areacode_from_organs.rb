class RemoveAddressPostalcodeAreacodeFromOrgans < ActiveRecord::Migration
  def up
    remove_column :organs, :address
    remove_column :organs, :postalcode
    remove_column :organs, :areacode
  end

  def down
    add_column :organs, :areacode, :string
    add_column :organs, :postalcode, :string
    add_column :organs, :address, :string
  end
end
