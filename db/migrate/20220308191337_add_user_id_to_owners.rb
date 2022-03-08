class AddUserIdToOwners < ActiveRecord::Migration[5.2]
  def change
    add_column :owners, :user_id, :integer
  end
end
