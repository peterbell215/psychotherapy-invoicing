class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :start, null: false
      t.integer :duration, null: false
      t.monetize :charge, null: false

      t.timestamps
    end
  end
end
