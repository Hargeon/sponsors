class CreateRequireHelps < ActiveRecord::Migration[6.0]
  def change
    create_table :require_helps do |t|
      t.string :name

      t.timestamps
    end
  end
end
