require 'httparty'

class TopicsController < ApplicationController
	def new
	end

	def create
		q = params[:topic][:text]
		response = HTTParty.get("https://www.googleapis.com/freebase/v1/search?query=&key=AIzaSyAmHdenRKINiNhTZZCPScUKuRwWaWt1KBg&filter=(any+broader_than:\"#{q}\" narrower_than:\"#{q}\")&indent=true");
		@res = response.body
	end

	def show
		@topic = Topic.find(params[:id])
	end
end
