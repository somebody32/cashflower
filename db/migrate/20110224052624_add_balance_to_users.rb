class AddBalanceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :balance, :decimal, :precision => 8, :scale => 2, :null => false, :default => 0.00
  end

  def self.down
    remove_column :users, :balance
  end
end
