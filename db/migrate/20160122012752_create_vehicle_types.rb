class CreateVehicleTypes < ActiveRecord::Migration
  def change
    create_table :vehicle_types do |t|
      t.string :name,        null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :slug,        null: false

      t.timestamps           null: false

      t.index  :name,        unique: true
      t.index  :slug,        unique: true
    end
  end
end
