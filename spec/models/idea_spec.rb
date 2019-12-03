require 'rails_helper'

RSpec.describe Idea, type: :model do
  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:industry) }
    it { should validate_presence_of(:focus) }
    it { should validate_presence_of(:plan) }

    it { should validate_length_of(:name).is_at_least(5) }
    it "count of description's words less 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight nine ten',
                      description: 'One two three')
      expect(idea).to eq(false)
    end

    it "count of description's words equals 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight nine ten',
                      description: 'One two three foor five six seven eight nine ten')
      expect(idea).to eq(true)
    end

    it "count of description's words more 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight nine ten',
                      description: 'One two three foor five six seven eight nine ten eleven')
      expect(idea).to eq(true)
    end

    it "count of plan's words less 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight',
                      description: 'One two three foor five six seven eight nine ten')
      expect(idea).to eq(false)
    end

    it "count of plan's words equals 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight nine ten',
                      description: 'One two three foor five six seven eight nine ten')
      expect(idea).to eq(true)
    end

    it "count of plan's words more 10" do
      idea = Idea.new(name: 'Simple name', industry: 1, focus: 1,
                      plan: 'One two three foor five six seven eight nine ten eleven',
                      description: 'One two three foor five six seven eight nine ten')
      expect(idea).to eq(true)
    end
  end
end
