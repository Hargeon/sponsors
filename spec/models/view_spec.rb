require 'rails_helper'

RSpec.describe View, type: :model do
  it { should validate_uniqueness_of(:user_id).scoped_to(:idea_id) }
end
