require_relative './spec_helper'

describe Ruflow::Action do

  describe '.change_options' do
    it 'must change options on class using merge' do
      klass = Ruflow::Action.clone

      klass.change_options(input: 'String')

      expect(klass.options).to eq Ruflow::Action.options.merge(input: 'String')
    end
  end

  describe '.with_custom_options' do
    it 'must clone and change options on cloned class' do
      expect(Ruflow::Action.with_custom_options(input: 'String').options[:input]).to eq 'String'
    end

    it 'must not redefined options with params' do
      klass = Ruflow::Action.clone
      klass.set_options(klass.options.merge(test: true))

      expect(klass.with_custom_options(input: 'String').options[:test]).to be true
    end

    it 'must not modify original Action' do
      original_klass = Ruflow::Action.with_custom_options(input: 'Fixnum')
      klass          = original_klass.with_custom_options(input: 'String')

      expect(original_klass.options).to_not eq klass.options
    end
  end

  describe '.start' do
    context 'if start method was not overwrite' do
      it 'must raise a NotImplementedError' do
        expect { Ruflow::Action.start }.to raise_error(NotImplementedError)
      end
    end

    context 'if start method was overwrite' do
      let(:action_klass) do
        action.class
      end

      let(:action) do
        action = Ruflow::Action.clone.new
        allow(action).to       receive(:start) { |arg1| [:ok, arg1] }
        allow(action.class).to receive(:new).and_return(action)
        action
      end

      context 'and input type is not the expected type' do
        it 'must raise a Error::MismatchInputType' do
          action_klass.set_options(action_klass.options.merge(input: 'Fixnum'))
          allow(action).to receive(:start).and_return('XY')

          expect { action_klass.start }.to raise_error(Ruflow::Error::MismatchInputType)
        end
      end

      context 'and start method return is not formated as [:<<output_port>>, <<value>>]' do
        it 'must raise a Error::BadReturnError' do
          allow(action).to receive(:start).and_return('XY')

          expect { action_klass.start }.to raise_error(Ruflow::Error::BadReturn)
        end
      end

      context 'and output_port is not defined' do
        it 'must raise a Error::BadReturnError' do
          action_klass.set_options(action_klass.options.merge(input: 'String'))
          allow(action).to receive(:start).and_return([:port_not_defined, 'teste'])

          expect { action_klass.start('teste') }.to raise_error(Ruflow::Error::OutputPortNotDefined)
        end
      end

      context 'and output value type is not the expected type' do
        it 'must raise a Error::MismatchOutputType' do
          action_klass.set_options(action_klass.options.merge(input: 'String', output: { ok: 'String' }))
          allow(action).to receive(:start).and_return([:ok, 123])

          expect { action_klass.start('teste') }.to raise_error(Ruflow::Error::MismatchOutputType)
        end
      end

      context 'and input type is the expected' do
        context 'and start method return in a proper format' do
          context 'and output value type is the expected type' do
            context 'and if input value is not set but default_input is set' do
              it 'must return a proper return with a valid output_port and value' do
                action_klass.set_options(action_klass.options.merge(default_input: 'teste1'))
                allow(action).to receive(:start) { |arg1| [:ok, arg1] }

                expect(action_klass.start).to eq [:ok, 'teste1']
              end
            end

            context 'and if input value is set' do
              it 'must return a proper return with a valid output_port and value' do
                allow(action).to receive(:start) { |arg1| [:ok, arg1] }

                expect(action_klass.start('teste2')).to eq [:ok, 'teste2']
              end
            end
          end
        end
      end
    end
  end

  describe '.input_type' do
    it 'alias to options[:input]' do
      expect(Ruflow::Action.input_type).to eq Ruflow::Action.options[:input]
    end
  end

  describe '#start' do
    context 'if start method was not overwrite' do
      it 'must raise a NotImplementedError' do
        expect { Ruflow::Action.new.start }.to raise_error(NotImplementedError)
      end
    end
  end
end
