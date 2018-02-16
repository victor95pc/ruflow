module Ruflow
  class Flow < Action

    def start(param)
      action = self.class.start_action
      value  = param

      while action[:output_to]
        output_port, value = action[:klass].start(value)

        action = self.class.actions[action[:output_to][output_port]]
      end

      action[:klass].start(value)
    end

    class << self
      attr_accessor :actions, :start_action_id

      alias_method :set_actions,         :actions=
      alias_method :set_start_action_id, :start_action_id=

      def check_actions!
        raise NotImplementedError, 'actions must be defined using set_actions({})' if actions.nil?

        raise NotImplementedError, 'start_action_id must be defined using set_start_action_id(Integer)' if start_action_id.nil?

        raise NotImplementedError, 'actions must be a Hash'  if not(actions.is_a?(Hash))

        raise NotImplementedError, 'start_action not found, change the start_action_id' if start_action.nil?

        if (actions_with_error = actions_without_klass).any?
          raise NotImplementedError, "actions id=#{actions_with_error.keys.join(', ')} must have value as a Hash and define a 'klass:' key"
        end

        if (actions_with_error = actions_mismatch_output_input_type).any?
          raise Error::MismatchOutputInputType.new(actions_with_error)
        end
      end

      def start
        check_actions!
        super(nil)
      end

      def start_action
        actions[start_action_id]
      end

      private

      def actions_without_klass
        actions.select { |_, a| not(a.is_a?(Hash)) || a[:klass].nil? }
      end

      def actions_with_output_to
        actions.select { |_, a| a[:output_to] }
      end

      def actions_mismatch_output_input_type
        actions_with_output_to.map do |action_id, action|

          action[:output_to].map do |port, next_action_id|
            action_input_type  = actions[next_action_id][:klass].options[:input]
            action_output_type = action[:klass].options[:output][port]

            if TypeChecker.incompatible_types?(action_input_type, action_output_type)
              {from_action_id: action_id, to_action_id: next_action_id, from: action_output_type, to: action_input_type, port: port}
            end
          end
        end.flatten.compact
      end
    end
  end
end