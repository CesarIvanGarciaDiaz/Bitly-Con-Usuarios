class CreateUsers < ActiveRecord::Migration
    def change
    create_table :users do |u|
      u.string :usuario, :unique => true
      u.string :mail,  :unique => true
      u.string :password
      u.timestamps
      end
    end
end
