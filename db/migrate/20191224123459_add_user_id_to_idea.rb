class AddUserIdToIdea < ActiveRecord::Migration[6.0]
  def change
    add_column :ideas, :user_id, :integer
  end
end
