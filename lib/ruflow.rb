require "configurations"
require 'require_all'

require "ruflow/version"
require "ruflow/type_checker"
require "ruflow/action"
require "ruflow/flow"

require "ruflow/error/bad_return"
require "ruflow/error/mismatch_input_type"
require "ruflow/error/mismatch_output_type"
require "ruflow/error/mismatch_output_input_type"
require "ruflow/error/output_port_not_defined"

module Ruflow
  include Configurations

  configurable :components_folder

  class << self
    def config
      configuration
    end

    def setup(&block)
      Ruflow.configure(&block)

      autoload_all "#{Dir.pwd}/#{config.components_folder}/actions"
      autoload_all "#{Dir.pwd}/#{config.components_folder}/flows"
    end
  end
end
