class CreateDraws < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.string :title
      t.text :message
      t.integer :user_id

      t.timestamps
    end
  end
end
