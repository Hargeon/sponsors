RSpec.shared_examples 'success action response' do
  it 'response has a status 200' do
    expect(response.status).to eq(200)
  end
end
