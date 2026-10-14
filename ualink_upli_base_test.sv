
`ifndef UALINK_UPLI_BASE_TEST_SV
`define UALINK_UPLI_BASE_TEST_SV

class ualink_upli_base_test extends uvm_test;
  `uvm_component_utils(ualink_upli_base_test)

  // ------------------------------------------------------------
  // Handles
  // ------------------------------------------------------------
  ualink_upli_basic_env      m_env;
  ualink_upli_cust_config    m_cfg;

  // ------------------------------------------------------------
  // Extern Method Declarations
  // ------------------------------------------------------------
  extern function new(string name = "ualink_upli_base_test",
                      uvm_component parent = null);

  extern function void build_phase(uvm_phase phase);

  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : ualink_upli_base_test

// ============================================================
// Function Definitions (Outside Class)
// ============================================================

function ualink_upli_base_test::new(string name = "ualink_upli_base_test",
                                    uvm_component parent = null);
  super.new(name, parent);
endfunction : new

// ------------------------------------------------------------
// build_phase
// ------------------------------------------------------------
function void ualink_upli_base_test::build_phase(uvm_phase phase);
  super.build_phase(phase);

  // Create CUSTOM config object
  m_cfg = ualink_upli_cust_config::type_id::create("m_cfg");

  // Create environment
  m_env = ualink_upli_basic_env::type_id::create("m_env", this);

  // Get UPLI virtual interface from config DB
  if (!uvm_config_db#(virtual ualink_upli_interface)::get(
        this, "", "upli_vif", m_cfg.upli_vif)) begin
    `uvm_fatal(
      $sformatf("%0s | build_phase", get_full_name()),
      "upli_intf not found in uvm_config_db"
    )
  end
  
  // Push config down to env and children
  uvm_config_db#(ualink_upli_cust_config)::set(
    this, "m_env", "upli_cfg", m_cfg);
 
 

endfunction : build_phase

// ------------------------------------------------------------
// end_of_elaboration_phase
// ------------------------------------------------------------
function void ualink_upli_base_test::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);

  `uvm_info(get_full_name(),
            "UALINK UPLI base test elaboration complete",
            UVM_LOW)
  uvm_top.print_topology();
endfunction : end_of_elaboration_phase

`endif // UALINK_UPLI_BASE_TEST_SV
