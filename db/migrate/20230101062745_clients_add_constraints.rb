class ClientsAddConstraints < ActiveRecord::Migration[7.0]
  def change
    change_table :clients do |t|
      t.change_null :name, false
      t.index :name
      t.change_null :address1, false
      t.change_null :town, false
      t.change_null :postcode, false
      t.string :email, index: true
    end
  end
end
