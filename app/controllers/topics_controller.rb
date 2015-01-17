require 'httparty'

class TopicsController < ApplicationController
	def new
	end

	def create
		freebaseReq = FreebaseRequest.new(params[:topic][:text])

		@res = freebaseReq.sendRequest()
	end

	def show
		@topic = Topic.find(params[:id])
	end
end
