class CreateAnimalMedicines < ActiveRecord::Migration[5.2]
  def change
    create_table :animal_medicines do |t|
      t.references :animal, foreign_key: true
      t.references :medicine, foreign_key: true
      t.integer :recommended_num_of_units

      # t.timestamps
    end
  end
end
