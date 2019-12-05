class CreateLocalRequireHelps < ActiveRecord::Migration[6.0]
  def change
    create_table :local_require_helps do |t|
      t.integer :idea_id
      t.integer :require_help_id

      t.timestamps
    end
  end
end
