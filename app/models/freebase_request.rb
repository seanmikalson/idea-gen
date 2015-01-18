require 'httparty'

class FreebaseRequest
	GOOGLE_APIS_URL = 'www.googleapis.com'
	FREEBASE_SEARCH = '/freebase/v1/search'

	# TODO store api key in a secure way
	API_KEY = 'AIzaSyAmHdenRKINiNhTZZCPScUKuRwWaWt1KBg'

	def initialize(topic)
		@topic = topic
		@filter = ""
	end

	# Sends the request off with the specified topic to freebase and returns the json body
	def send()
		uri = URI::HTTPS.build({:host => GOOGLE_APIS_URL, :path => FREEBASE_SEARCH, 
			:query => {:query => "", :key => API_KEY, :filter => @filter}.to_query})
		response = HTTParty.get(uri)
	end

end