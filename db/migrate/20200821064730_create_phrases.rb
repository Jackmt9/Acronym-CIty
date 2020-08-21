class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrases do |t|
      t.text :text
      t.integer :medium_id

      t.timestamps
    end
  end
end
