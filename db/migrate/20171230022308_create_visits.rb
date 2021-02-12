class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.references :pet, foreign_key: true
      t.date :date
      t.float :weight
      t.boolean :overnight_stay
      t.integer :total_charge  # should default to zero, but want to show ||= later...

      # t.timestamps
    end
  end
end
