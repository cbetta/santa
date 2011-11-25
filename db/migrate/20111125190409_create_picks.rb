class CreatePicks < ActiveRecord::Migration
  def change
    create_table :picks do |t|
      t.integer :picker_id
      t.integer :picked_id
      t.string :hash
      t.boolean :has_checked

      t.timestamps
    end
  end
end
