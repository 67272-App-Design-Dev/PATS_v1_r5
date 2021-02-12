class CreateMedicineCosts < ActiveRecord::Migration[5.2]
  def change
    create_table :medicine_costs do |t|
      t.references :medicine, foreign_key: true
      t.integer :cost_per_unit
      t.date :start_date
      t.date :end_date

      # t.timestamps
    end
  end
end
