class MakeDb < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :catalog_items do |t|
      t.string :name
      t.string :description
      t.integer :amount_cents
      t.timestamps
    end

    create_table :purchases do |t|
      t.references :catalog_item
      t.references :user
      t.string :token
      t.string :payment_id
      t.string :payment_status
    end

    CatalogItem.create!(name: 'Box of Rocks', description: 'Have a large box of rocks delivered to your doorstep.  You can use them to enhance your doorstep!', amount_cents: 200)
    CatalogItem.create!(name: 'Rock of Boxes', description: 'The all new music CD focused on organization!', amount_cents: 2000)
    User.create!(name: 'Ulala Sasson')
    User.create!(name: 'Random Personage')
    User.create!(name: 'Indescribable Essence')
    User.create!(name: 'Bitter Melon')
    User.create!(name: 'Jenova Sephiroth')
  end
end
