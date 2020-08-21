class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrase do |t|
      t.string :phrase
      t.integer :medium_id

      t.timestamps
    end
  end
end
