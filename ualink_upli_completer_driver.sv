`ifndef UALINK_UPLI_COMPLETER_DRIVER_SV
`define UALINK_UPLI_COMPLETER_DRIVER_SV

class ualink_upli_completer_driver extends uvm_driver #(ualink_upli_completer_transaction);

  `uvm_component_utils(ualink_upli_completer_driver)

  // Virtual interface handle
  virtual ualink_upli_completer_interface vif;

  protected ualink_upli_completer_active_common common;

  extern function new(string name = "ualink_upli_completer_driver", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function set_common(ualink_upli_completer_active_common common);

endclass: ualink_upli_completer_driver

function ualink_upli_completer_driver::new(string name = "ualink_upli_completer_driver", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

function void ualink_upli_completer_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(virtual ualink_upli_completer_interface)::get(this, "", "vif", vif)) begin
    `uvm_fatal(get_type_name(), "virtual interface not set for ualink_upli_completer_driver")
  end
endfunction: build_phase

task ualink_upli_completer_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);
  common.async_init_signals();
  common.update_on_reset();

  forever begin
    @(posedge vif.upli_resetn);

    fork
      common.start();

      begin
        @(negedge vif.upli_resetn);
      end

      forever begin
        seq_item_port.get_next_item(req);
        common.drive_xact(req);
        seq_item_port.item_done();
      end
    join_any

    disable fork;

    common.async_init_signals();
    common.update_on_reset();
  end

endtask: run_phase

function ualink_upli_completer_driver::set_common(ualink_upli_completer_active_common common);
  this.common = common;
  this.common.driver = this;
endfunction: set_common

`endif // UALINK_UPLI_COMPLETER_DRIVER_SV
