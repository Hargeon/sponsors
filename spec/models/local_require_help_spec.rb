require 'rails_helper'

RSpec.describe LocalRequireHelp, type: :model do
  it { should validate_uniqueness_of(:require_help_id).scoped_to(:idea_id) }
end
