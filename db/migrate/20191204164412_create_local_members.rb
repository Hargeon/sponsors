class CreateLocalMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :local_members do |t|
      t.integer :amount
      t.integer :member_id
      t.integer :idea_id

      t.timestamps
    end
  end
end
