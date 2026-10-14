`ifndef UALINK_UPLI_COMPLETER_TRANSACTION_SV
`define UALINK_UPLI_COMPLETER_TRANSACTION_SV

class ualink_upli_completer_transaction extends ualink_upli_transaction;

  `uvm_object_utils(ualink_upli_completer_transaction)

  function new (string name = "ualink_upli_completer_transaction");
    super.new(name);
  endfunction

  // Add variables to control completer driver signals.

  // Add Constraint for UPLI Request.

  // Methods
  extern function void pre_randomize();

endclass: ualink_upli_completer_transaction

`protect
function void ualink_upli_completer_transaction::pre_randomize();
  // Disable all the random variables of request. Completer only randomize response signals.

  // ============================================================
  // Request Channel
  // ============================================================
  req_vld.rand_mode(0);
  req_port_id.rand_mode(0);
  req_asi.rand_mode(0);
  req_auth_tag.rand_mode(0);
  req_src_phys_acc_id.rand_mode(0);
  req_dst_phys_acc_id.rand_mode(0);
  req_tag.rand_mode(0);
  req_num_beats.rand_mode(0);
  req_addr.rand_mode(0);
  req_cmd.rand_mode(0);
  req_len.rand_mode(0);
  req_attr.rand_mode(0);
  req_meta_data.rand_mode(0);
  req_vc.rand_mode(0);
  req_pool.rand_mode(0);

  // ============================================================
  // Originator Data Channel
  // ============================================================
  orig_data_vld.rand_mode(0);
  orig_data_port_id.rand_mode(0);
  orig_data_offset.rand_mode(0);
  orig_data_last.rand_mode(0);
  orig_data_error.rand_mode(0);
  orig_data_vc.rand_mode(0);
  orig_data_pool.rand_mode(0);
  orig_data_byte_en.rand_mode(0);

  // Dynamic data beats
  orig_data.rand_mode(0);

endfunction: pre_randomize
`endprotect
`endif // UALINK_UPLI_COMPLETER_TRANSACTION_SV
