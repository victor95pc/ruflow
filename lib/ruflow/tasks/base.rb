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
        _file_path = "#{Dir.pwd}/ruflow_config"

        if File.exist?("#{_file_path}.rb")
          require _file_path
          Kernel.const_get(flow_klass_name).start
        else
          puts "ruflow_config.rb not found on #{Dir.pwd}"
        end
      end

      desc "setup", "Generate all files and folder required"
      def setup
        Ruflow::Tasks::Setup.start(['.'])
      end
    end
  end
end