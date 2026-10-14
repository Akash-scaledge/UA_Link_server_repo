
`ifndef UALINK_upli_basic_env_SV
`define UALINK_upli_basic_env_SV

class ualink_upli_basic_env extends uvm_env;

  `uvm_component_utils(ualink_upli_basic_env)

  ualink_upli_cust_config upli_cfg;

  ualink_upli_env upli_env;
  ualink_tl_env tl_env;

  extern function new(string name = "ualink_upli_basic_env", uvm_component parent);

  extern virtual function void build_phase(uvm_phase phase);

endclass: ualink_upli_basic_env

function ualink_upli_basic_env::new(string name = "ualink_upli_basic_env", uvm_component parent);

  super.new(name, parent);

endfunction: new

function void ualink_upli_basic_env::build_phase(uvm_phase phase);

  super.build_phase(phase);

  upli_env = ualink_upli_env::type_id::create("upli_env", this);
  //   $display("UPLI_ENV OBJ CREATED IN BASIC ENV");         //USED FOR DEBUG
  tl_env = ualink_tl_env::type_id::create("tl_env", this);
  if(!uvm_config_db#(ualink_upli_cust_config)::get(this,"","upli_cfg",upli_cfg))begin
    `uvm_fatal(get_full_name(), "ualink_upli_basic_env::build_phase | Didn't get ualink_upli_cust_config form config_db");
  end

  uvm_config_db#(ualink_upli_env_config)::set(this,"upli_env","upli_cfg",upli_cfg);
    uvm_config_db#(ualink_upli_env_config)::set(this,"tl_env","tl_upli_cfg",upli_cfg);    //USED FOR DEBUG

endfunction: build_phase

`endif // UALINK_upli_basic_env_SV
