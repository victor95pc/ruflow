module Flows
  class HelloWorld < ::Ruflow::Flow
    set_actions({
      1 => { klass: ::Actions::Printer.with_custom_options(can_print: false, text: 'Hello'), output_to: { ok: 2 } },
      2 => { klass: ::Actions::Printer.with_custom_options(can_print: false, text: 'Hello'), output_to: { ok: 3 } },
      3 => { klass: ::Actions::Printer.with_custom_options(can_print: false, text: 'Again'), output_to: { ok: 4 } },
      4 => { klass: ::Actions::Printer.with_custom_options(can_print: true,  text: 'World') }
    })

    set_start_action_id(1)
  end
end