class CreateLocalIndustries < ActiveRecord::Migration[6.0]
  def change
    create_table :local_industries do |t|
      t.integer :idea_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
