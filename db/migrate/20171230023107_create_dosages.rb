class CreateDosages < ActiveRecord::Migration[5.2]
  def change
    create_table :dosages do |t|
      t.references :visit, foreign_key: true
      t.references :medicine, foreign_key: true
      t.integer :units_given
      t.float :discount, default: 0.00

      # t.timestamps
    end
  end
end
