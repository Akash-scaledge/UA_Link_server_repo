`ifndef UALINK_UPLI_CUST_CONFIG_SV
`define UALINK_UPLI_CUST_CONFIG_SV

class ualink_upli_cust_config extends ualink_upli_env_config;

  `uvm_object_utils(ualink_upli_cust_config)

  extern function new(string name = "ualink_upli_cust_config");

endclass: ualink_upli_cust_config

function ualink_upli_cust_config::new(string name = "ualink_upli_cust_config");
  super.new(name);
endfunction: new

`endif // UALINK_UPLI_CUST_CONFIG_SV
