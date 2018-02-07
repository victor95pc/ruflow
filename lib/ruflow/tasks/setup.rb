require "thor"

module Ruflow
  module Tasks
    class Setup < Thor::Group
      include Thor::Actions

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_lib_file
        directory '../../../setup_files', '.'
      end
    end
  end
end