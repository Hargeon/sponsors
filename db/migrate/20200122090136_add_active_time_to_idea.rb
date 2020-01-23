class AddActiveTimeToIdea < ActiveRecord::Migration[6.0]
  def change
    add_column :ideas, :active_time, :datetime
  end
end
