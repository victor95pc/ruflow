class Flows::HelloWorld < Ruflow:Flow
  set_actions({
    1 => { klass: Printer.with_custom_options(can_print: false, text: 'Hello'), output_to: { success: 2 } },
    2 => { klass: Printer.with_custom_options(can_print: false, text: 'Hello'), output_to: { success: 3 } },
    3 => { klass: Printer.with_custom_options(can_print: false, text: 'Again'), output_to: { success: 4 } },
    4 => { klass: Printer.with_custom_options(can_print: true,  text: 'World') },
  })

  set_start_action_id(1)
end