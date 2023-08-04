class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :postal_code
      t.string :address
      t.string :name
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
