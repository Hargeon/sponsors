class CreateLocalDistricts < ActiveRecord::Migration[6.0]
  def change
    create_table :local_districts do |t|
      t.integer :idea_id
      t.integer :district_id

      t.timestamps
    end
  end
end
