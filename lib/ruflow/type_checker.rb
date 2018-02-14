module Ruflow
  module TypeChecker
    def self.incompatible_types?(type, compare_type)
      !compatible_types?(type, compare_type)
    end

    def self.compatible_types?(type, compare_type)
      return true if compare_type.include? '*'

      compare_types = compare_type.split('|')

      type.split('|').any? { |t| compare_types.include?(t) }
    end

    def self.is_invalid?(value, type:)
      !is_valid?(value, type: type)
    end

    def self.is_valid?(value, type:)
      return true if type.include? '*'

      types = type.split('|').map { |t| get_constant(t) }.flatten

      types.any? { |t| value.is_a?(t) }
    end

    private

    def self.get_constant(type)
      type == 'Boolean' ? [TrueClass, FalseClass] : [Kernel.const_get(type)]
    end
  end
end