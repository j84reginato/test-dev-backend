class CreateOrderFoods < ActiveRecord::Migration
  def change
    create_table :order_foods do |t|
      t.text :body

      t.timestamps null: false
    end
  end
end
