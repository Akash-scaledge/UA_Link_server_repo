
`ifndef UALINK_UPLI_COMMON_SV
`define UALINK_UPLI_COMMON_SV

class ualink_upli_common;

  // Set when reset asserted
  protected bit is_reset;

  ualink_upli_config cfg;

  // Array to store credit for request channel per port and per VC
  int upli_req_channel_credit_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0][2**(`UPLI_MAX_REQ_VC_WIDTH)-1:0];

  // Array to store request channel pool credit per port.
  int upli_req_channel_credit_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  // Array to store credit for orignator data channel per port and per VC
  int upli_orig_data_channel_credit_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0][(2**`UPLI_MAX_REQ_VC_WIDTH)-1:0];

  // Array to store orignator data channel pool credit per port.
  int upli_orig_data_channel_credit_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  // Array to store credit for write response channel per port and per VC
  int upli_wr_rsp_channel_credit_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0][2**(`UPLI_MAX_REQ_VC_WIDTH)-1:0];

  // Array to store write response channel pool credit per port.
  int upli_wr_rsp_channel_credit_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  // Array to store credit for read response channel per port and per VC
  int upli_rd_rsp_channel_credit_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0][2**(`UPLI_MAX_REQ_VC_WIDTH)-1:0];

  // Array to store read response channel pool credit per port.
  int upli_rd_rsp_channel_credit_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  // Array to store status that initial credit for port finished for request channel
  bit [`UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH-1:0] upli_req_channel_credit_init_done;

  // Array to store status that initial pool credit for port finished for orignator data channel
  bit [`UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH-1:0] upli_orig_data_channel_credit_init_done;

  // Array to store status that initial credit for port finished for write response channel
  bit [`UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH-1:0] upli_wr_rsp_channel_credit_init_done;

  // Array to store status that initial pool credit for port finished for read response channel
  bit [`UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH-1:0] upli_rd_rsp_channel_credit_init_done;

  bit is_orig_if_handshake_done;

  bit is_comp_if_handshake_done;

  /**
   * CONSTRUCTURE
   */
  extern function new(ualink_upli_config cfg, uvm_report_object reporter);

  /**
   * reconfigure to reset all the variables of this class when reset asserted.
   */
  extern virtual function void reconfigure (ualink_upli_config re_cfg);

  /**
   * update_on_reset to reset all the variables of this class when reset asserted.
   */
  extern virtual task update_on_reset();

endclass: ualink_upli_common

// ===============================================
function ualink_upli_common::new(ualink_upli_config cfg, uvm_report_object reporter);
  this.cfg = cfg;
endfunction: new

// ===============================================
function void ualink_upli_common::reconfigure(ualink_upli_config re_cfg);

endfunction: reconfigure

// ===============================================
task ualink_upli_common::update_on_reset();

  for (int port_id = 0; port_id < (2**`UPLI_MAX_REQ_PORT_ID_WIDTH); port_id++) begin
    upli_req_channel_credit_pool[port_id] = 0; 
    upli_orig_data_channel_credit_pool[port_id] = 0; 
    upli_wr_rsp_channel_credit_pool[port_id] = 0; 
    upli_rd_rsp_channel_credit_pool[port_id] = 0; 
    for (int vc_num = 0; vc_num < (2**`UPLI_MAX_REQ_VC_WIDTH); vc_num++) begin
      upli_req_channel_credit_vc[port_id][vc_num] = 0;
      upli_orig_data_channel_credit_vc[port_id][vc_num] = 0;
      upli_wr_rsp_channel_credit_vc[port_id][vc_num] = 0;
      upli_rd_rsp_channel_credit_vc[port_id][vc_num] = 0;
    end
  end
    
  upli_req_channel_credit_init_done = 0;
  upli_orig_data_channel_credit_init_done = 0;
  upli_wr_rsp_channel_credit_init_done = 0;
  upli_rd_rsp_channel_credit_init_done = 0;
  is_orig_if_handshake_done = 0;
  is_comp_if_handshake_done = 0;

endtask: update_on_reset

`endif // UALINK_UPLI_COMMON_SV
