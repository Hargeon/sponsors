class AddIndicesToTables < ActiveRecord::Migration[6.0]
  def change
    add_index :dislikes, :user_id
    add_index :dislikes, :idea_id
    add_index :ideas, :user_id
    add_index :interests, :user_id
    add_index :interests, :idea_id
    add_index :likes, :user_id
    add_index :likes, :idea_id
    add_index :local_districts, [:idea_id, :district_id]
    add_index :local_industries, [ :idea_id, :industry_id]
    add_index :local_members, [:idea_id, :member_id]
    add_index :local_require_helps, [:idea_id, :require_help_id]
    add_index :ratings, :idea_id
    add_index :ratings, :user_id
    add_index :sponsor_districts, [:user_id, :district_id]
    add_index :sponsor_helps, [:user_id, :require_help_id]
    add_index :sponsor_industries, [:user_id, :industry_id]
    add_index :views, :user_id
    add_index :views, :idea_id
  end
end
