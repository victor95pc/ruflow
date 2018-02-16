module Ruflow
  module Error
    class MismatchOutputInputType < StandardError
      attr_reader :errors
      
      def initialize(errors, msg="Mismatches found in: ")
        @errors = Array(errors)
        super(msg + format_errors)
      end

      private

      def format_errors
        @errors.map { |e| "ACTION_ID=#{e[:from_action_id]} to ACTION_ID=#{e[:to_action_id]} mismatch type on port #{e[:port]} (#{e[:from]} to #{e[:to]})" }
               .join(', ')
      end
    end
  end
end