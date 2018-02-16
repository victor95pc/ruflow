module Ruflow
  module Error
    class MismatchInputType < StandardError
      def initialize(value, expect_type)
        super("Expected INPUT as #{expect_type}, but received #{value.class}")
      end
    end
  end
end