class AddDisallowedMembers < ActiveRecord::Migration
  def change
    add_column :draws, :previous_draw_id, :integer
  end
end
