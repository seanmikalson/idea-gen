require 'httparty'
require 'treenode'

class TopicsController < ApplicationController

	def new
	end

	def create
		input = params[:topic][:text]
		@res = getAllRelatedTopics(input)
	end

	def show
		@n = getAllRelatedTopics(params[:id])
		render :layout => "expand"
	end

	def getAllRelatedTopics (topic)

		rootNode = TreeNode.new(topic)
		rootNode.expand
		rootNode
	end
end
