require 'httparty'

class TopicsController < ApplicationController

	def new
	end

	def create
		input = params[:topic][:text]
		@res = getAllRelatedTopics(input,3)
	end

	def show
		@topic = Topic.find(params[:id])
	end

	def getAllRelatedTopics (topic, depth)
		listToQuery = getRelatedTo(topic)
		allRelated = listToQuery

		for i in 0..depth
			tempList = []
			listToQuery.each do |r|
				Logger.new(STDOUT).info r
				if r != nil
					getRelatedTo(r['name']).each do |e|
						tempList.push(e)
					end
				end
			end
			listToQuery = tempList
			listToQuery.each do |e|
				allRelated.push(e)
			end
		end 

		allRelated
	end

	def getRelatedTo(topic)
		results = []
		broadrequest = BroadFreebaseRequest.new(topic)
		rawResponse = broadrequest.send().body
		jsonResponse = JSON.parse(rawResponse)
		results = jsonResponse['result']

		narrowrequest = NarrowFreebaseRequest.new(topic)
		rawResponse = narrowrequest.send().body
		jsonResponse = JSON.parse(rawResponse)
		jsonResponse['result'].each do |result|
			results.push(result)
		end
		results
	end
end
