require 'httparty'

class TopicsController < ApplicationController
	def new
		response = HTTParty.get('http://www.google.ca');
		@res = response.body
	end

	def create
		@topic = Topic.new(topic_params)

		@topic.save
		redirect_to @topic
	end

	def show
		@topic = Topic.find(params[:id])
	end

	private
		def topic_params
			params.require(:topic).permit(:text)
		end
end
