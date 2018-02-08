require "thor"

module Ruflow
  module Tasks
    class Base < Thor
      desc "new", "generate a new project"
      def new(project_name)
        puts "I'm a thor task! #{project_name}"
      end

      def setup
        puts "Run Run"
      end
    end
  end
end