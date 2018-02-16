module Ruflow
  module Error
    class OutputPortNotDefined < StandardError
      def initialize(return_value)
        super("Expected start method to return [:<<output_port>>, <<value>>], but returned #{return_value}")
      end
    end
  end
end