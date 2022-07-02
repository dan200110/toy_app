class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.decimal :price
      t.integer :quantity
      t.text :description

      t.datetime :publish_year
      t.string :pushlish_name


      t.timestamps
    end
  end
end
