class ChangeChargeAttributes < ActiveRecord::Migration[7.0]
  def change
    rename_column :sessions, :charge_pence, :hourly_charge_pence
    rename_column :sessions, :charge_currency, :hourly_charge_currency

    rename_column :session_charges, :charge_rate_pence, :hourly_charge_rate_pence
    rename_column :session_charges, :charge_rate_currency, :hourly_charge_rate_currency
  end
end
