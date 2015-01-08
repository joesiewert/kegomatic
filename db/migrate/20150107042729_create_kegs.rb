class CreateKegs < ActiveRecord::Migration
  def change
    create_table :kegs do |t|
      t.string :name
      t.string :size
      t.decimal :price
      t.timestamps
    end
  end
end
