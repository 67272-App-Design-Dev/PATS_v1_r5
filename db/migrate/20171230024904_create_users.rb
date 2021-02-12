class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :username
      t.string :password_digest
      t.boolean :active

      # t.timestamps
    end
  end
end
