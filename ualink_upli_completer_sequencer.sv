`ifndef UALINK_UPLI_COMPLETER_SEQUENCER_SV
`define UALINK_UPLI_COMPLETER_SEQUENCER_SV

class ualink_upli_completer_sequencer extends uvm_sequencer #(ualink_upli_completer_transaction);

  `uvm_component_utils(ualink_upli_completer_sequencer)

  function new(string name = "ualink_upli_completer_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif // UALINK_UPLI_COMPLETER_SEQUENCER_SV
