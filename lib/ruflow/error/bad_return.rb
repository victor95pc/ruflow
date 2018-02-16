module Ruflow
  module Error
    class BadReturn < StandardError
      def initialize(return_value)
        super("Expected start to return [:<<output_port>>, <<value>>], but returned #{return_value}")
      end
    end
  end
end