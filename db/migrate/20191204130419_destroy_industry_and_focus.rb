class DestroyIndustryAndFocus < ActiveRecord::Migration[6.0]
  def change
    remove_column :ideas, :industry, :integer
    remove_column :ideas, :focus, :integer
  end
end
