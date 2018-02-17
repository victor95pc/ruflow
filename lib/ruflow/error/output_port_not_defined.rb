module Ruflow
  module Error
    class OutputPortNotDefined < StandardError
      def initialize(output_ports, output_port)
        super("Output port (#{output_port}) not defined, ports defined are: #{output_ports.join(', ')}")
      end
    end
  end
end