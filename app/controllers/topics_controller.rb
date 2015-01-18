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
		rootNode.expand(depth)
		rootNode
	end
end
