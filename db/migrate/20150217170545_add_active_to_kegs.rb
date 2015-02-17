class AddActiveToKegs < ActiveRecord::Migration
  def change
    add_column :kegs, :active, :boolean, default: true
  end
end
