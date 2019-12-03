class CreateIdeas < ActiveRecord::Migration[6.0]
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :description
      t.integer :industry
      t.integer :focus
      t.text :plan

      t.timestamps
    end
  end
end
