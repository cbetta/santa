class AddUidToConnections < ActiveRecord::Migration
  def change
    add_column :connections, :uid, :string
  end
end
