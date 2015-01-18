class NarrowFreebaseRequest < FreebaseRequest

	def initialize(topic)
		super topic
		@filter = "(all narrower_than:\"#{@topic}\")"
	end
end