class AddSalePriceAndUrlToKegs < ActiveRecord::Migration
  def change
    add_column :kegs, :sale_price, :decimal
    add_column :kegs, :url, :string
  end
end
