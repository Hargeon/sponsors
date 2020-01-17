RSpec.shared_examples 'unsuccess action response' do
  it 'response has a status 403' do
    expect(response.status).to eq(403)
  end
end
