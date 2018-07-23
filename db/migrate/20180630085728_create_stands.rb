class CreateStands < ActiveRecord::Migration[5.1]
  def change
    create_table :stands do |t|
      t.string :area
      t.string :name
      t.string :image
      t.text :description

      t.timestamps
    end
  end
end
