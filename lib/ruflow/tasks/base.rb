require_relative 'setup'

module Ruflow
  module Tasks
    class Base < Thor
      desc "new  [PROJECT_NAME]", "generate a new project"
      def new(project_name)
        Ruflow::Tasks::Setup.start([project_name])
      end

      desc "setup", "generate all files and folder required"
      def setup
        Ruflow::Tasks::Setup.start(['.'])
      end
    end
  end
end