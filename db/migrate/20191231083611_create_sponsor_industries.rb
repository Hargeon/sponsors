class CreateSponsorIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :sponsor_industries do |t|
      t.integer :user_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
