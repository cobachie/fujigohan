class AddOrderToStands < ActiveRecord::Migration[5.1]
  def change
    add_column :stands, :order, :integer
  end
end
