class AddDefaultPlayerColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :default_player, :string
  end
end
