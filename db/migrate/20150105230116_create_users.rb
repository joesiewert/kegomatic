class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.boolean :admin, default: false
      t.string :password_digest
      t.timestamps
    end
  end
end
