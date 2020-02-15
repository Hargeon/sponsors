require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:phone) }
    it { should validate_length_of(:name).is_at_least(4) }
    it { should validate_numericality_of(:age).is_greater_than_or_equal_to(12) }
    it { should validate_numericality_of(:age).only_integer }
    it { should validate_numericality_of(:age).is_less_than(150) }
    it { should validate_length_of(:name).is_at_most(15) }
  end
end
