require 'rails_helper'

RSpec.describe Rating, type: :model do
  let(:minimum_number) { 1 }
  let(:maximum_number) { 5 }

  it { should validate_uniqueness_of(:user_id).scoped_to(:idea_id) }

  it do
    should validate_numericality_of(:attraction)
            .is_greater_than_or_equal_to(minimum_number)
            .is_less_than_or_equal_to(maximum_number)
  end

  it do
    should validate_numericality_of(:strategy)
            .is_greater_than_or_equal_to(minimum_number)
            .is_less_than_or_equal_to(maximum_number)
  end
  it do
    should validate_numericality_of(:competitiveness)
            .is_greater_than_or_equal_to(minimum_number)
            .is_less_than_or_equal_to(maximum_number)
  end

  it do
    should validate_numericality_of(:finance)
            .is_greater_than_or_equal_to(minimum_number)
            .is_less_than_or_equal_to(maximum_number)
  end
end
