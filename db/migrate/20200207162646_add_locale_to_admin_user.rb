class AddLocaleToAdminUser < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_users, :locale, :string
  end
end
