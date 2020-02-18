url = ENV['BONSAI_URL']
Elasticsearch::Model.client = Elasticsearch::Client.new url: url
