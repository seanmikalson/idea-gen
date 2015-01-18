class TreeNode
	attr_reader :value, :children, :expanded

	def initialize(value)
		@value = value
		@children = []
	end

	# Maintain ref to root for access to entire tree (search)
	def setRoot(node)
		@root = node
	end

	def addChild(node)
		@children.push(node)
	end

	def expand(level)
		if(level > 0)
			@expanded = true
			children = getRelatedTo(@value)

			# The each loop takes care of case where nothing is related to value
			children.each do |relatedTopic|

				alreadyExpanded = isExpanded(@root, relatedTopic['name'])
				childNode = TreeNode.new(relatedTopic['name'])
				childNode.setRoot(@root)
				self.addChild(childNode)

				if !alreadyExpanded
					childNode.expand(level-1)
				end
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

	# Returns true if value already expanded in the tree
	def isExpanded(startNode, value)
		startNode.children.each do |node|
			if node.value == value
				return node.expanded
			else 
				if isExpanded(node, value)
					return true
				end
			end
		end
		false
	end
end