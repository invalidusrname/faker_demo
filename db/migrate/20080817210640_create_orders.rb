class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :invoice
      t.text :description
      t.text :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
