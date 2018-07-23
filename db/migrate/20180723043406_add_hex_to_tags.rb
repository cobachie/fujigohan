class AddHexToTags < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :hex, :string
  end
end
