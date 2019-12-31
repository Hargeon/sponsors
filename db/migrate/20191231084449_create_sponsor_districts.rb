class CreateSponsorDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :sponsor_districts do |t|
      t.integer :user_id
      t.integer :district_id

      t.timestamps
    end
  end
end
