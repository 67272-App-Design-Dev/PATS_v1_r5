class CreateTreatments < ActiveRecord::Migration[5.2]
  def change
    create_table :treatments do |t|
      t.references :visit, foreign_key: true
      t.references :procedure, foreign_key: true
      t.boolean :successful
      t.float :discount, default: 0.00

      # t.timestamps
    end
  end
end
