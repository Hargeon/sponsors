RSpec.shared_examples 'unsuccess action json' do
  it 'should be message error' do
    expected = { 'message': 'error' }.to_json
    expect(response.body).to eq(expected)
  end
end
