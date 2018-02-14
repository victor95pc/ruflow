require_relative './spec_helper'

describe Ruflow::TypeChecker do
  describe '.compatible_types?' do
    context 'when type is a String' do
      context 'and compare type can be only a String' do
        it 'must be a compatible type' do
          expect(described_class.compatible_types?('String', 'String')).to be true
        end
      end

      context 'and compare type can be a String or a Boolean' do
        it 'must be a compatible type' do
          expect(described_class.compatible_types?('String', 'String|Boolean')).to be true
        end
      end

      context 'and compare type can be anything' do
        it 'must be a compatible type' do
          expect(described_class.compatible_types?('String', '*')).to be true
        end
      end
    end
  end


  describe '.is_valid?' do
    context 'when value is a String' do
      context 'and expect type can be only a String' do
        it 'checker must be valid' do
          expect(described_class.is_valid?('Teste', type: 'String')).to be true
        end
      end

      context 'and expect type can be a String or a Boolean' do
        it 'checker must be valid' do
          expect(described_class.is_valid?('Teste', type: 'String|Boolean')).to be true
        end
      end

      context 'and expect type can be anything' do
        it 'checker must be valid' do
          expect(described_class.is_valid?('Teste', type: '*')).to be true
        end
      end
    end

    context 'when value is a Boolean' do
      context 'and expect type can be only a Boolean' do
        it 'checker must be valid' do
          expect(described_class.is_valid?(true, type: 'Boolean')).to be true
        end
      end

      context 'and expect type can be a String or a Boolean' do
        it 'checker must be valid' do
          expect(described_class.is_valid?(false, type: 'String|Boolean')).to be true
        end
      end

      context 'and expect type can be anything' do
        it 'checker must be valid' do
          expect(described_class.is_valid?(true, type: '*')).to be true
        end
      end
    end
  end


  describe '.incompatible_types?' do
    context 'when type is a String' do
      context 'and compare type can be only a Boolean' do
        it 'must be a incompatible type' do
          expect(described_class.incompatible_types?('String', 'Boolean')).to be true
        end
      end
    end

    context 'when type can be anything' do
      context 'and compare type can be only a String' do
        it 'must be a incompatible type' do
          expect(described_class.incompatible_types?('*', 'String')).to be true
        end
      end
    end
  end


  describe '.is_invalid?' do
    context 'when value is a String' do
      context 'and expect type can be only a Boolean' do
        it 'checker must be invalid' do
          expect(described_class.is_invalid?('Teste', type: 'Boolean')).to be true
        end
      end
    end

    context 'when value is a Boolean' do
      context 'and expect type can be only a String' do
        it 'checker must be invalid' do
          expect(described_class.is_invalid?(true, type: 'String')).to be true
        end
      end
    end
  end
end
