class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.float :attraction
      t.float :strategy
      t.float :competitiveness
      t.float :finance
      t.integer :idea_id
      t.integer :user_id

      t.timestamps
    end
  end
end
