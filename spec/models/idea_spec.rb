require 'rails_helper'

RSpec.describe Idea, type: :model do
  context 'validations' do
    let(:name) { 'Simple name' }
    let(:description) { 'one two three fout five six seven eight nine ten' }
    let(:plan) { 'one two three fout five six seven eight nine ten' }
    let(:idea) { Idea.new(name: name, description: description, plan: plan) }

    it { should validate_length_of(:name).is_at_least(4) }

    it 'count words of description equals 10' do
      expect(idea.valid?).to eq(true)
    end

    it 'count words of plan equals 10' do
      expect(idea.valid?).to eq(true)
    end

    context 'description has less than 10 words' do
      let(:description) { 'one two three fout five six seven eight nine' }
      let(:idea) { Idea.new(name: name, description: description, plan: plan) }

      it 'should be invalid' do
        expect(idea.valid?).to eq(false)
      end
    end

    context 'plan has less than 10 words' do
      let(:plan) { 'one two three fout five six seven eight nine' }
      let(:idea) { Idea.new(name: name, description: description, plan: plan) }

      it 'should be invalid' do
        expect(idea.valid?).to eq(false)
      end
    end
  end
end
