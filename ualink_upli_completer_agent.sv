`ifndef UALINK_UPLI_COMPLETER_AGENT_SV
`define UALINK_UPLI_COMPLETER_AGENT_SV

class ualink_upli_completer_agent extends uvm_agent;

  `uvm_component_utils(ualink_upli_completer_agent)

  virtual ualink_upli_completer_interface comp_vif;

  // Components inside the agent
  ualink_upli_config                   cfg;
  ualink_upli_completer_active_common  active_common;
  ualink_upli_completer_monitor_common monitor_common;
  ualink_upli_completer_driver        comp_driver;
  ualink_upli_completer_monitor       comp_monitor;
  ualink_upli_completer_sequencer     comp_sequencer;

  extern function new(string name = "ualink_upli_completer_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass: ualink_upli_completer_agent

// Constructor
function ualink_upli_completer_agent::new(string name = "ualink_upli_completer_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

// Build phase
function void ualink_upli_completer_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //  $display("%s",get_full_name());          //USED FOR DEBUG
  if (!uvm_config_db#(ualink_upli_config)::get(this, "", "comp_cfg", cfg))begin
    `uvm_fatal(get_full_name(), "Unable to get ualink_upli_config from database");
  end
  if(!uvm_config_db#(bit)::get(this, "", "is_active", cfg.is_active)) begin
    `uvm_error(get_full_name(),"Agent active or passive not set");
  end
  //   if(cfg==null) $display("%s",{get_full_name()," ","cfg obj is null"});     //USED FOR DEBUG
  if(comp_vif == null) `uvm_fatal(get_full_name(), "comp_vif is NULL");
  uvm_config_db#(virtual ualink_upli_completer_interface)::set(this, "*", "vif", comp_vif); // DEBUG: SET THE COMPLETER IF
  // Always create monitor
  comp_monitor = ualink_upli_completer_monitor::type_id::create("comp_monitor", this);
  monitor_common = new(cfg, null);
  monitor_common.completer_monitor = comp_monitor;
  monitor_common.set_interface(comp_vif);
  comp_monitor.set_common(monitor_common);

  // Create driver + sequencer only if active
  if (cfg.is_active) begin
    comp_driver    = ualink_upli_completer_driver::type_id::create("comp_driver", this);
    active_common  = new(cfg, null);
    active_common.driver = comp_driver;
    active_common.completer_monitor = comp_monitor;
    active_common.set_interface(comp_vif);
    comp_driver.set_common(active_common);
    comp_sequencer = ualink_upli_completer_sequencer::type_id::create("comp_sequencer", this);
  end
endfunction: build_phase

// Connect phase
function void ualink_upli_completer_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if (cfg.is_active) begin
    comp_driver.seq_item_port.connect(comp_sequencer.seq_item_export);
  end

endfunction: connect_phase

`endif // UALINK_UPLI_COMPLETER_AGENT_SV
