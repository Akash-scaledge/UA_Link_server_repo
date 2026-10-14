`ifndef UALINK_TL_ENV_SV  
 `define UALINK_TL_ENV_SV


 class ualink_tl_env extends uvm_env;
 `uvm_component_utils(ualink_tl_env)

   ualink_upli_env_config upli_cfg;//USED FOR DEBUG ONLY
  // Agent handles
  ualink_upli_originator_agent tl_tx_agent;
  ualink_upli_completer_agent tl_rx_agent;

  // Transactor handles
  ualink_tl_tx_flit_transactor tx_transactor;
  //ualink_tl_rx_flit_transactor rx_transactor;

  // Scoreboard and coverage
   //  ualink_tl_scoreboard tl_scbd;
   //  ualink_tl_coverage   tl_cov;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(ualink_upli_env_config)::get(this,"","tl_upli_cfg",upli_cfg))begin//USED FOR DEBUG ONLY
    `uvm_fatal(get_full_name(), "ualink_upli_env::build_phase | Didn't get ualink_upli_env_config form config_db");
  end
    tl_tx_agent   = ualink_upli_originator_agent::type_id::create("tl_tx_agent", this);
    tl_rx_agent   = ualink_upli_completer_agent::type_id::create("tl_rx_agent", this);
    tx_transactor = ualink_tl_tx_flit_transactor::type_id::create("tx_transactor", this);
    uvm_config_db#(ualink_upli_config)::set(this,"tl_tx_agent","orig_cfg",upli_cfg.orig_cfg[0]);
    uvm_config_db#(ualink_upli_config)::set(this,"tl_rx_agent","comp_cfg",upli_cfg.comp_cfg[0]);
    // rx_transactor = ualink_tl_rx_flit_transactor::type_id::create("rx_transactor", this);
    // tl_scbd       = ualink_tl_scoreboard::type_id::create("tl_scbd", this);
    // tl_cov        = ualink_tl_coverage::type_id::create("tl_cov", this);
    uvm_config_db#(bit)::set(this,"tl_tx_agent","is_active",1);
    uvm_config_db#(bit)::set(this,"tl_rx_agent","is_active",1);
    tl_rx_agent.comp_vif = upli_cfg.upli_vif.get_completer_if(0); // receives app requests
    tl_tx_agent.orig_vif = upli_cfg.upli_vif.get_orignator_if(1); // issues requests to app
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

  //Connect tl_tx_agent => tx_transactor via TLM for outbound transactions: 
  // tl_tx_agent.monitor.ap.connect(tx_transactor.upli_fifo.analysis_export); //To update as per the TLM used in protocol layer ( w.r.t Req)
 
  // Connect Originator agent response to TL TX FLIT TRANSACTOR => DLL : 
  // originator_agent.monitor.ap.connect(tx_transactor..TL_to_DLL_resp_analysis_imp); //To update as per the TLM used in protocol layer ( w.r.t Resp)

  // Connect RX transactor Response to UPLI_Agent_Completer ( coming from DLL) : 
  //  rx_transactor.ap.connect(completer_agent.monitor.DLL_to_TL_resp_analysis_export);  //To update as per the TLM used in protocol layer ( w.r.t Resp)

  // Connect RX transactor Req to UPLI_Agent_originator ( coming from DLL) : 
  //  rx_transactor.ap.connect(originator_agent.monitor.DLL_to_TL_req_analysis_export);  //To update as per the TLM used in protocol layer ( w.r.t Req)

  //SCOREBOARD connections: 
    // Connect TX transactor ( REQ/RESP)  to scoreboard 

    // Connect TX transactor ( REQ/RESP)  to scoreboard 

  //COVERAGE connections:

 endfunction

 endclass
`endif // UALINK_TL_ENV_SV

