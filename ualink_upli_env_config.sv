
`ifndef UALINK_UPLI_ENV_CONFIG_SV
`define UALINK_UPLI_ENV_CONFIG_SV

class ualink_upli_env_config extends uvm_object;

  `uvm_object_utils(ualink_upli_env_config)

  // Confing for number of orignator agents
  int num_orignator_agent=`UPLI_NUM_OF_ORIGINATOR;

  // Confing for number of completer agents
  int num_completer_agent=`UPLI_NUM_OF_COMPLETER;

  // UPLI Interface
  virtual ualink_upli_interface upli_vif;

  // Dynamic array of ualink_upli_config for orignator agents.
  ualink_upli_config orig_cfg[];

  // Dynamic array of ualink_upli_config for completer agents.
  ualink_upli_config comp_cfg[];

  extern function new(string name = "ualink_upli_env_config");
  extern function create_sub_config();

endclass: ualink_upli_env_config

function ualink_upli_env_config::new(string name = "ualink_upli_env_config");
  super.new(name);
  create_sub_config();
endfunction: new

function ualink_upli_env_config::create_sub_config();

  orig_cfg = new[num_orignator_agent];
  comp_cfg = new[num_completer_agent];

  for (int i = 0; i < num_orignator_agent; i++)begin
    orig_cfg[i] = ualink_upli_config::type_id::create($sformatf("orig_cfg_%0d",i));
  end

  for (int i = 0; i < num_completer_agent; i++)begin
    comp_cfg[i] = ualink_upli_config::type_id::create($sformatf("comp_cfg_%0d",i));
  end

endfunction: create_sub_config

`endif // UALINK_UPLI_ENV_CONFIG_SV
