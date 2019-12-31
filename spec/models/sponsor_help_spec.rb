require 'rails_helper'

RSpec.describe SponsorHelp, type: :model do
  it { should validate_uniqueness_of(:user_id).scoped_to(:require_help_id) }
end
