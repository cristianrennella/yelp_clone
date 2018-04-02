class CreateBusiness < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
    	t.string :name, :address, :food_type
    	t.timestamps
    end
  end
end
