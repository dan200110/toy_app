class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :roles, default: 0
      t.boolean :activated, default: false
      t.datetime :activated_at
      t.string :password_digest
      t.string :activation_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps
    end
  end
end
