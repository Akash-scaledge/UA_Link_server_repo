`ifndef UALINK_UPLI_ORIGINATOR_AGENT_SV
`define UALINK_UPLI_ORIGINATOR_AGENT_SV

class ualink_upli_originator_agent extends uvm_agent;

  `uvm_component_utils(ualink_upli_originator_agent)

  virtual ualink_upli_orignator_interface orig_vif;

  // Components inside the agent
  ualink_upli_config                   cfg;
  ualink_upli_orignator_active_common  active_common;
  ualink_upli_orignator_monitor_common monitor_common;
  ualink_upli_originator_driver        orig_driver;
  ualink_upli_originator_monitor       orig_monitor;
  ualink_upli_originator_sequencer     orig_sequencer;

  extern function new(string name = "ualink_upli_originator_agent", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
endclass: ualink_upli_originator_agent

// Constructor
function ualink_upli_originator_agent::new(string name = "ualink_upli_originator_agent", uvm_component parent = null);
  super.new(name, parent);
endfunction: new

// Build phase
function void ualink_upli_originator_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if (!uvm_config_db#(ualink_upli_config)::get(this, "", "orig_cfg", cfg))begin
    `uvm_fatal(get_full_name(), "Unable to get ualink_upli_config from database");
  end
  if(!uvm_config_db#(bit)::get(this, "", "is_active", cfg.is_active)) begin
    `uvm_error(get_full_name(),"Agent active or passive not set");
  end

  if(orig_vif == null) `uvm_fatal(get_full_name(), "orig_vif is NULL");
  uvm_config_db#(virtual ualink_upli_orignator_interface)::set(this, "*", "vif", orig_vif);// DEBUG : SET THE ORIGINATOR IF
  // Always create monitor
  orig_monitor = ualink_upli_originator_monitor::type_id::create("orig_monitor", this);
  monitor_common = new(cfg, null);
  monitor_common.orignator_monitor = orig_monitor;
  monitor_common.set_interface(orig_vif);
  orig_monitor.set_common(monitor_common);

  // Create driver + sequencer only if active
  if (cfg.is_active) begin
    orig_driver    = ualink_upli_originator_driver::type_id::create("orig_driver", this);
    active_common  = new(cfg, null);
    active_common.driver = orig_driver;
    active_common.orignator_monitor = orig_monitor;
    active_common.set_interface(orig_vif);
    orig_driver.set_common(active_common);
    orig_sequencer = ualink_upli_originator_sequencer::type_id::create("orig_sequencer", this);
  end
endfunction: build_phase

// Connect phase
function void ualink_upli_originator_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if (cfg.is_active) begin
    orig_driver.seq_item_port.connect(orig_sequencer.seq_item_export);
  end

endfunction: connect_phase

`endif // UALINK_UPLI_ORIGINATOR_AGENT_SV
