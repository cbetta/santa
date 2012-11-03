class RenameHash < ActiveRecord::Migration
  def change
    rename_column :picks, :hash, :token
  end
end
