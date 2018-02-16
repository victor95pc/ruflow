module Ruflow
  class Action
    class << self
      attr_accessor :options

      alias_method :set_options, :options=

      def change_options(_options = {})
        self.options = (options || {}).merge(_options)
      end

      def with_custom_options(_options = {})
        klass = self.clone
        klass.change_options(_options)
        klass
      end

      def start(param = nil)
        _param = param.nil? ? options[:default_input] : param

        type_check_input!(_param, input_type)
        output_port_and_value = self.new.start(_param)

        check_return!(output_port_and_value)

        output_port, value = output_port_and_value

        check_output_port_is_defined!(output_port)

        output_type = options[:output][output_port]

        type_check_output!(value, output_type)

        [output_port, value]
      end

      def input_type
        options[:input]
      end

      private

      def type_check_input!(value, input_type)
        if TypeChecker.is_invalid?(value, type: input_type)
          raise Error::MismatchInputType.new(value, input_type)
        end
      end

      def check_return!(return_value)
        if return_value.class != Array || return_value.first.class != Symbol
          raise Error::BadReturn.new(return_value)
        end
      end

      def check_output_port_is_defined!(output_port)
        _output_port = options[:output][output_port]

        if _output_port.nil? || _output_port.empty?
          raise Error::OutputPortNotDefined.new(_output_port)
        end
      end

      def type_check_output!(value, output_type)
        if TypeChecker.is_invalid?(value, type: output_type)
          raise Error::MismatchOutputType.new(value, output_type)
        end
      end
    end

    set_options(
      default_input: nil,
      input:  '*',
      output: {
        ok: '*'
      }
    )

    def start(value = nil)
      raise NotImplementedError, 'Overwrite instance method start'
    end

    protected

    def options
      self.class.options
    end
  end
end