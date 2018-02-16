module Actions
  class Printer < ::Ruflow::Action
    set_options(
      default_input: '',
      input: 'String',
      output: {
        ok: 'String'
      }
    )

    def self.with_custom_options(can_print:, text:)
      super(can_print: can_print, text: text)
    end

    def start(text)
      puts text if options[:can_print]

      [:ok, text + options[:text]]
    end
  end
end