class CreateElections < ActiveRecord::Migration
  def change
    create_table :elections do |t|
      t.boolean :active, default: false
      t.belongs_to :keg
      t.timestamps
    end
  end
end
