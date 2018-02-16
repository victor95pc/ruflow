require_relative './spec_helper'

describe Ruflow::Flow do

  class DumbAction < Ruflow::Action
    def start(value)
      [:ok, value + options[:text]]
    end
  end

  class DumbFlow < Ruflow::Flow
    set_actions({
      1 => { klass: DumbAction.with_custom_options(text: 'Hello ', default_input: ''), output_to: { ok: 2 } },
      2 => { klass: DumbAction.with_custom_options(text: 'Again '), output_to: { ok: 3 } },
      3 => { klass: DumbAction.with_custom_options(text: 'World') },
    })

    set_start_action_id(1)

    def self.start
      self.new.start(nil)
    end
  end

  describe '.start!' do
    it 'must run all action in the flow and return the formated result [:ok, "Hello Again World"]' do
      expect(DumbFlow.start).to eq([:ok, "Hello Again World"])
    end
  end

  describe '.check_actions!' do
    let(:cloned_flow) do
      Ruflow::Flow.clone
    end

    context 'if actions is not defined' do
      it 'must raise a NotImplementedError' do
        expect { cloned_flow.check_actions! }.to raise_error(NotImplementedError)
      end
    end

    context 'if start_action_id is not defined' do
      it 'must raise a NotImplementedError' do
        cloned_flow.set_actions({})

        expect { cloned_flow.check_actions! }.to raise_error(NotImplementedError)
      end
    end

    context 'if ACTIONS is not a Hash' do
      it 'must raise a NotImplementedError' do
        cloned_flow.set_actions([])
        cloned_flow.set_start_action_id(0)

        expect { cloned_flow.check_actions! }.to raise_error(NotImplementedError)
      end
    end

    context 'if START_ACTION_ID is not defined in ACTIONS' do
      it 'must raise a NotImplementedError' do
        cloned_flow.set_actions({ 0 => Ruflow::Action })
        cloned_flow.set_start_action_id(1)

        expect { cloned_flow.check_actions! }.to raise_error(NotImplementedError)
      end
    end

    context 'if actions inside ACTIONS doesnt defined klass key' do
      it 'must raise a NotImplementedError' do
        cloned_flow.set_actions({ 1 => nil, 2 => 'test', 3 => Ruflow::Action, 4 => { klass: Ruflow::Action } })
        cloned_flow.set_start_action_id(2)

        expect { cloned_flow.check_actions! }.to raise_error(NotImplementedError, /[123]/)
      end
    end

    context 'if actions output type conflicts with input type(Mismatch Type)' do
      it 'must raise a MismatchOutputInputType' do
        cloned_flow.set_actions({
          1 => { klass: DumbAction.with_custom_options(input: 'String', output: { ok: 'Boolean' }), output_to: { ok: 2 } },
          2 => { klass: DumbAction.with_custom_options(input: 'String', output: { ok: 'String' }),  output_to: { ok: 3 } },
          3 => { klass: DumbAction.with_custom_options(input: 'String', output: { ok: 'Boolean' }), output_to: { ok: 4 } },
          4 => { klass: DumbAction.with_custom_options(input: 'String', output: { ok: 'String' }) }
        })

        cloned_flow.set_start_action_id(1)

        expect { cloned_flow.check_actions! }.to raise_error(Ruflow::Error::MismatchOutputInputType)
      end
    end
  end
end
