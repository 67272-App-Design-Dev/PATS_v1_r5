class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :notable_type
      t.integer :notable_id
      t.string :title
      t.text :content
      t.references :user, foreign_key: true
      t.datetime :written_on

      # t.timestamps
    end
  end
end
