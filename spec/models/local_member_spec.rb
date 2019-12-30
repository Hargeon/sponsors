require 'rails_helper'

RSpec.describe LocalMember, type: :model do
  describe 'validate' do
    it { should validate_numericality_of(:amount).only_integer }
    it { should validate_numericality_of(:amount).is_greater_than_or_equal_to(0) }
  end
end
