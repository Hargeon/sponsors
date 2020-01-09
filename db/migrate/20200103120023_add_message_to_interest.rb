class AddMessageToInterest < ActiveRecord::Migration[6.0]
  def change
    add_column :interests, :message, :string
  end
end
