class CreateMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :medicines do |t|
      t.string :name
      t.text :description
      t.integer :stock_amount
      t.string :admin_method
      t.string :unit
      t.boolean :vaccine
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
