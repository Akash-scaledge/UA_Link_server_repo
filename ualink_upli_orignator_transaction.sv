`ifndef UALINK_UPLI_ORIGNATOR_TRANSACTION_SV
`define UALINK_UPLI_ORIGNATOR_TRANSACTION_SV

class ualink_upli_orignator_transaction extends ualink_upli_transaction;

  `uvm_object_utils(ualink_upli_orignator_transaction)

  function new (string name = "ualink_upli_orignator_transaction");
    super.new(name);
  endfunction

  // Add variables to control Orignator driver signals.

  // Add Constraint for UPLI Request.

  // Methods
  extern function void pre_randomize();
  extern virtual function bit is_wr_rsp_credit_update_pkt();
  extern virtual function bit is_rd_rsp_credit_update_pkt();
  extern virtual function bit is_request_pkt();

endclass: ualink_upli_orignator_transaction

`protect
function void ualink_upli_orignator_transaction::pre_randomize();
  // Disable all the random variables of response. Orignator only randomize request signals.

  // -----------------------------
  // Write Response Channel
  // -----------------------------
  wr_rsp_port_id.rand_mode(0);
  wr_rsp_auth_tag.rand_mode(0);
  wr_rsp_src_phys_acc_id.rand_mode(0);
  wr_rsp_dst_phys_acc_id.rand_mode(0);
  wr_rsp_tag.rand_mode(0);
  wr_rsp_status.rand_mode(0);
  wr_rsp_vc.rand_mode(0);
  wr_rsp_pool.rand_mode(0);

  // -----------------------------
  // Read Response + Data Channel
  // -----------------------------
  rd_rsp_port_id.rand_mode(0);
  rd_rsp_auth_tag.rand_mode(0);
  rd_rsp_src_phys_acc_id.rand_mode(0);
  rd_rsp_dst_phys_acc_id.rand_mode(0);
  rd_rsp_tag.rand_mode(0);
  rd_rsp_num_beats.rand_mode(0);
  rd_rsp_status.rand_mode(0);
  rd_rsp_offset.rand_mode(0);
  rd_rsp_last.rand_mode(0);
  rd_rsp_data_error.rand_mode(0);
  rd_rsp_vc.rand_mode(0);
  rd_rsp_pool.rand_mode(0);

endfunction: pre_randomize

function bit ualink_upli_orignator_transaction::is_wr_rsp_credit_update_pkt();

  return wr_rsp_credit_vld || wr_rsp_credit_init_done;

endfunction: is_wr_rsp_credit_update_pkt

function bit ualink_upli_orignator_transaction::is_rd_rsp_credit_update_pkt();

  return rd_rsp_credit_vld || rd_rsp_credit_init_done;

endfunction: is_rd_rsp_credit_update_pkt

function bit ualink_upli_orignator_transaction::is_request_pkt();

  return req_vld;

endfunction: is_request_pkt

`endprotect
`endif // UALINK_UPLI_ORIGNATOR_TRANSACTION_SV
