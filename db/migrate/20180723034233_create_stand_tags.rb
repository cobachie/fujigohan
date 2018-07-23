class CreateStandTags < ActiveRecord::Migration[5.1]
  def change
    create_table :stand_tags do |t|
      t.references :stand, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
