class AddDaysToPlant < ActiveRecord::Migration[5.2]
  def change 
    change_table :plants do |t|
      t.integer :days_til_harvest
    end
  end
end
