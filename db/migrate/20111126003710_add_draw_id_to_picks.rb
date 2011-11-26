class AddDrawIdToPicks < ActiveRecord::Migration
  def change
    add_column :picks, :draw_id, :integer
  end
end
