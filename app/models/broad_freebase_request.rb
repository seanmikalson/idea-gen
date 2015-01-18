class BroadFreebaseRequest < FreebaseRequest

	def initialize(topic)
		super topic
		@filter = "(all broader_than:\"#{@topic}\")"
	end

end