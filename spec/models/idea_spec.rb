require 'rails_helper'

RSpec.describe Idea, type: :model do
  context 'validations' do
    it { should validate_length_of(:name).is_at_least(4) }
    it 'count words of description less 10' do
      idea = Idea.new(name: 'Simple name',
                      plan: 'one two three fout five six seven eight nine ten',
                      description: 'one two three fout five six seven eight nine').save
      expect(idea).to eq(false)
    end

    it 'count words of description equals 10' do
      idea = Idea.new(name: 'Simple name',
                      plan: 'one two three fout five six seven eight nine ten',
                      description: 'one two three fout five six seven eight nine ten').save
      expect(idea).to eq(true)
    end

    it 'count words of plan less 10' do
      idea = Idea.new(name: 'Simple name',
                      plan: 'one two three fout five six seven eight nine',
                      description: 'one two three fout five six seven eight nine ten').save
      expect(idea).to eq(false)
    end
    it 'count words of plan equals 10' do
      idea = Idea.new(name: 'Simple name',
                      plan: 'one two three fout five six seven eight nine ten',
                      description: 'one two three fout five six seven eight nine ten').save
      expect(idea).to eq(true)
    end
  end
end
