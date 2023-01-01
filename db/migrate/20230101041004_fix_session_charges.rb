class FixSessionCharges < ActiveRecord::Migration[7.0]
  def change
    change_table :session_charges do |t|
      t.change_default :hourly_charge_rate_pence, 6000
      t.change_null :from, false
    end
  end
end
