class AddPublicToIdea < ActiveRecord::Migration[6.0]
  def change
    add_column :ideas, :active, :boolean
  end
end
