class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :gender
      t.string :email
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.date :birthdate

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
