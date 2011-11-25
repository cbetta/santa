class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :draw_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
