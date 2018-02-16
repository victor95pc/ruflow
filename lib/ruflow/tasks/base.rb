require_relative 'setup'
require_relative '../../ruflow'

module Ruflow
  module Tasks
    class Base < Thor
      desc "new  [PROJECT_NAME]", "Generate a new project"
      def new(project_name)
        Ruflow::Tasks::Setup.start([project_name])
      end

      desc "start [FLOW_CLASS_NAME]", "Start a flow"
      def start(flow_klass_name)
        Kernel.const_get(flow_klass_name).start
      end

      desc "setup", "Generate all files and folder required"
      def setup
        Ruflow::Tasks::Setup.start(['.'])
      end
    end
  end
end