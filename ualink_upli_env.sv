
`ifndef UALINK_UPLI_ENV_SV
`define UALINK_UPLI_ENV_SV

class ualink_upli_env extends uvm_env;

  `uvm_component_utils(ualink_upli_env)

  ualink_upli_env_config upli_cfg;

  ualink_upli_originator_agent upli_orignator_agent[];

  ualink_upli_completer_agent upli_completer_agent[];

  extern function new(string name = "ualink_upli_env", uvm_component parent);

  extern virtual function void build_phase(uvm_phase phase);

endclass: ualink_upli_env

function ualink_upli_env::new(string name = "ualink_upli_env", uvm_component parent);

  super.new(name, parent);

endfunction: new

function void ualink_upli_env::build_phase(uvm_phase phase);
  //   $display("build phase of upli_env");             //USED FOR DEBUG
  super.build_phase(phase);

  if(!uvm_config_db#(ualink_upli_env_config)::get(this,"","upli_cfg",upli_cfg))begin
    `uvm_fatal(get_full_name(), "ualink_upli_env::build_phase | Didn't get ualink_upli_env_config form config_db");
  end
  //   if(upli_cfg==null) $display("###########%s",{get_full_name()," ","cfg obj is null"});   //USED FOR DEBUG
  upli_orignator_agent = new[upli_cfg.num_orignator_agent];
  upli_completer_agent = new[upli_cfg.num_completer_agent];

  for(int i = 0; i< upli_cfg.num_orignator_agent; i++)begin
    upli_orignator_agent[i] = ualink_upli_originator_agent::type_id::create($sformatf("upli_orignator_agent_%0d",i),this);
    
    uvm_config_db#(ualink_upli_config)::set(this,$sformatf("upli_orignator_agent_%0d",i),"orig_cfg",upli_cfg.orig_cfg[i]);
    uvm_config_db#(bit)::set(this,$sformatf("upli_orignator_agent_%0d",i),"is_active",1);
//     if(upli_cfg.orig_cfg[i]==null) $display("###########%s",{get_full_name()," ",$sformatf("upli_orignator_cfg_%0d",i)," ","cfg obj is null"});  //USED FOR DEBUG
    //     $display("SET CONFIG ORG");   //USED FOR DEBUG
    upli_orignator_agent[i].orig_vif = upli_cfg.upli_vif.get_orignator_if(0);     // APP → TL link
    
  end

  for(int i = 0; i< upli_cfg.num_completer_agent; i++)begin
    upli_completer_agent[i] = ualink_upli_completer_agent::type_id::create($sformatf("upli_completer_agent_%0d",i),this);
    uvm_config_db#(ualink_upli_config)::set(this,$sformatf("upli_completer_agent_%0d",i),"comp_cfg",upli_cfg.comp_cfg[i]);
    uvm_config_db#(bit)::set(this,$sformatf("upli_completer_agent_%0d",i),"is_active",1);
//     if(upli_cfg.orig_cfg[i]==null) $display("###########%s",{get_full_name()," ",$sformatf("upli_completer_cfg_%0d",i)," ","cfg obj is null"});    //USED FOR DEBUG
    //     $display("SET CONFIG CMP");   //USED FOR DEBUG
    upli_completer_agent[i].comp_vif = upli_cfg.upli_vif.get_completer_if(1); // TL → APP link
  end

endfunction: build_phase

`endif // UALINK_UPLI_ENV_SV
