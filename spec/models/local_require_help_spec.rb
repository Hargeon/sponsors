require 'rails_helper'

RSpec.describe LocalRequireHelp, type: :model do
  describe 'Uniq ids' do
    let(:require_help) { RequireHelp.first }
    it 'should be invalid' do
      idea = create(:idea)
      new_require_help = idea.local_require_helps.build(require_help_id: require_help.id)
      expect(new_require_help.valid?).to eq(false)
    end
  end
end
