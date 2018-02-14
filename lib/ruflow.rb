require "ruflow/version"
require "ruflow/type_checker"
require "configurations"

module Ruflow
  include Configurations

  configurable :components_folder

  class << self
    def config
      configuration
    end

    def setup(&block)
      Ruflow.configure(&block)
    end
  end
end
