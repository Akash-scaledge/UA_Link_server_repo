`ifndef UALINK_UPLI_ORIGINATOR_SEQUENCER_SV
`define UALINK_UPLI_ORIGINATOR_SEQUENCER_SV

class ualink_upli_originator_sequencer extends uvm_sequencer #(ualink_upli_orignator_transaction);

  `uvm_component_utils(ualink_upli_originator_sequencer)

  function new(string name = "ualink_upli_originator_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif
