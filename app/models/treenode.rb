class TreeNode
	attr_reader :value, :children

	def initialize(value)
		@value = value
		@children = []
	end

	def addChild(node)
		@children.push(node)
	end

end