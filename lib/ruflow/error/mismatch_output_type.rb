module Ruflow
  module Error
    class MismatchOutputType < StandardError
      def initialize(value, expect_type)
        super("Expected OUTPUT to be a #{expect_type}, but was #{value.class}")
      end
    end
  end
end