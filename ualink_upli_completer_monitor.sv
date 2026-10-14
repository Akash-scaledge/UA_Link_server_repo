`ifndef UALINK_UPLI_COMPLETER_MONITOR_SV
`define UALINK_UPLI_COMPLETER_MONITOR_SV

class ualink_upli_completer_monitor extends uvm_monitor;

  `uvm_component_utils(ualink_upli_completer_monitor)

  // Virtual interface
  virtual ualink_upli_completer_interface vif;

  ualink_upli_completer_monitor_common common;

  // Analysis port to send observed transactions
  uvm_analysis_port #(ualink_upli_completer_transaction) comp_mon_ap;

  extern function new(string name = "ualink_upli_completer_monitor", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function set_common(ualink_upli_completer_monitor_common common);
endclass: ualink_upli_completer_monitor

function ualink_upli_completer_monitor::new(string name = "ualink_upli_completer_monitor", uvm_component parent = null);
  super.new(name, parent);
  comp_mon_ap = new("comp_mon_ap", this);
endfunction

function void ualink_upli_completer_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(virtual ualink_upli_completer_interface)::get(this, "", "vif", vif)) begin
    `uvm_fatal(get_type_name(), "virtual interface not set for ualink_upli_completer_monitor")
  end
endfunction: build_phase

task ualink_upli_completer_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  common.update_on_reset();
  forever begin
    @(posedge vif.upli_resetn);

    fork
      common.start();
      begin
        @(negedge vif.upli_resetn);
      end
    join_any

    disable fork;
    common.update_on_reset();
  end
endtask: run_phase

function ualink_upli_completer_monitor::set_common(ualink_upli_completer_monitor_common common);
  this.common = common;
endfunction: set_common

`endif // UALINK_UPLI_COMPLETER_MONITOR_SV
