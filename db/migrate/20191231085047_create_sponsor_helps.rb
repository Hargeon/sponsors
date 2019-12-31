class CreateSponsorHelps < ActiveRecord::Migration[6.0]
  def change
    create_table :sponsor_helps do |t|
      t.integer :user_id
      t.integer :require_help_id

      t.timestamps
    end
  end
end
