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

	def expand
		children = getRelatedTo(@value)

		# The each loop takes care of case where nothing is related to value
		children.each do |relatedTopic|
			childNode = TreeNode.new(relatedTopic)
			childNode.setRoot(@root)
			self.addChild(childNode)
		end
		self
	end

	def getRelatedTo(topic)
		results = []
		broadrequest = BroadFreebaseRequest.new(topic)
		rawResponse = broadrequest.send().body
		jsonResponse = JSON.parse(rawResponse)
		jsonResponse['result'].each do |result|
			results.push(result['name'])
		end


		narrowrequest = NarrowFreebaseRequest.new(topic)
		rawResponse = narrowrequest.send().body
		jsonResponse = JSON.parse(rawResponse)
		jsonResponse['result'].each do |result|
			results.push(result['name'])
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

	def getExistingNode(startNode, value)
		startNode.children.each do |node|
			if startNode == node
				next
			elsif node.value == value
				return node
			else 
				existingNode = getExistingNode(node,value)
				return existingNode
			end
		end
		nil
	end

	def clone
		node = TreeNode.new(@value)
		node.setRoot(@root)
		@children.each do |childNode|
			node.addChild(childNode.clone)
		end
		node
	end
end