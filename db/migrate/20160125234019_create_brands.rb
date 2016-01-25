class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :code,        null: false, default: ''
      t.string :description, null: false, default: ''
      t.string :slug,        null: false

      t.timestamps           null: false

      t.index  :code,        unique: true
      t.index  :description, unique: true
      t.index  :slug,        unique: true
    end
  end
end
