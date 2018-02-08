module Ruflow
  module Tasks
    class Setup < Thor::Group
      include Thor::Actions

      argument :project_name, :type => :string, :desc => "Project name"

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_lib_file
        directory '../../../setup_files', project_name
      end

      def bundle_project
        inside(project_name) do
          run('bundler install')
        end
      end
    end
  end
end