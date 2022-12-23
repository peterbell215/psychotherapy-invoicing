class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :town
      t.string :postcode

      t.timestamps
    end
  end
end
