class TreeNode
	attr_reader :value, :children

	def initialize(value)
		@value = value
		@children = []
	end

	def addChild(node)
		@children.push(node)
	end

	def expand(level)
		if(level > 0)
			children = getRelatedTo(@value)
			children.each do |relatedTopic|
				childNode = TreeNode.new(relatedTopic['name'])
				
				childNode.expand(level-1)
				self.addChild(childNode)
			end
		end
		self
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