class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :first_name
      t.string :zipcode
      t.float :latitude
      t.float :longitude
      t.text :profile_picture
      t.integer :age
      t.text :about_me

      t.timestamps
    end
  end
end
