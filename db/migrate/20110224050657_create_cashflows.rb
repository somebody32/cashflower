class CreateCashflows < ActiveRecord::Migration
  def self.up
    create_table :cashflows do |t|
      t.integer :user_id, :null => false
      t.decimal :value, :precision => 8, :scale => 2, :null => false
      t.string :note
      t.timestamps
    end

    add_index :cashflows, :user_id
  end

  def self.down
    drop_table :cashflows
  end
end
