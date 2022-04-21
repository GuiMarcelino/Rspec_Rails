describe 'Httparty' do
  it 'Content-Type', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body]} do
    # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2").
    #   to_return(status: 200, body: "", headers: { 'content-type': 'application/json' })
    #
    response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/4')
    content_type = response.headers['content-type']
    expect(content_type).to match(/application\/json/)

  end
end