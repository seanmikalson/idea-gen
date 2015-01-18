require 'httparty'
require 'treenode'

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

		rootNode = TreeNode.new(topic)
		expandNode(rootNode, depth)
		rootNode

	end

	def expandNode(node, level)
		if(level > 0)
			children = getRelatedTo(node.value)
			children.each do |relatedTopic|
				childNode = TreeNode.new(relatedTopic['name'])
				
				expandNode(childNode, level-1)
				node.addChild(childNode)
			end
		end
		node
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
