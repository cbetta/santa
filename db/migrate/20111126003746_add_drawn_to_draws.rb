class AddDrawnToDraws < ActiveRecord::Migration
  def change
    add_column :draws, :drawn, :boolean
    add_column :draws, :drawn_on, :datetime
  end
end
