`ifndef UPLI_HDL_WRAPPER_SV
`define UPLI_HDL_WRAPPER_SV
// ============================================================================
// UPLI HDL Wrapper
// Full signal connectivity (Originator <-> Completer)
// ============================================================================

module upli_hdl_wrapper
(
  ualink_upli_interface         upli_if
);

  genvar i;
  generate
    for (i = 0; i < `UPLI_NUM_OF_ORIGNATOR_IF; i++) begin : GEN_UPLI_CONN

      // ============================================================
      // Interface Control Signals
      // ============================================================
      assign upli_if.upli_completer_interface[i].orig_clk_req =
             upli_if.upli_orignator_interface[i].orig_clk_req;

      assign upli_if.upli_orignator_interface[i].comp_clk_ack =
             upli_if.upli_completer_interface[i].comp_clk_ack;

      assign upli_if.upli_completer_interface[i].orig_clk_ack =
             upli_if.upli_orignator_interface[i].orig_clk_ack;

      assign upli_if.upli_orignator_interface[i].comp_clk_req =
             upli_if.upli_completer_interface[i].comp_clk_req;

      // ============================================================
      // Request Channel (Originator → Completer)
      // ============================================================
      assign upli_if.upli_completer_interface[i].req_valid                 = upli_if.upli_orignator_interface[i].req_valid;
      assign upli_if.upli_completer_interface[i].req_port_id               = upli_if.upli_orignator_interface[i].req_port_id;
      assign upli_if.upli_completer_interface[i].req_asi                   = upli_if.upli_orignator_interface[i].req_asi;
      assign upli_if.upli_completer_interface[i].req_auth_tag              = upli_if.upli_orignator_interface[i].req_auth_tag;
      assign upli_if.upli_completer_interface[i].req_src_phys_acc_id       = upli_if.upli_orignator_interface[i].req_src_phys_acc_id;
      assign upli_if.upli_completer_interface[i].req_dst_phys_acc_id       = upli_if.upli_orignator_interface[i].req_dst_phys_acc_id;
      assign upli_if.upli_completer_interface[i].req_tag                   = upli_if.upli_orignator_interface[i].req_tag;
      assign upli_if.upli_completer_interface[i].req_num_beats             = upli_if.upli_orignator_interface[i].req_num_beats;
      assign upli_if.upli_completer_interface[i].req_addr                  = upli_if.upli_orignator_interface[i].req_addr;
      assign upli_if.upli_completer_interface[i].req_cmd                   = upli_if.upli_orignator_interface[i].req_cmd;
      assign upli_if.upli_completer_interface[i].req_len                   = upli_if.upli_orignator_interface[i].req_len;
      assign upli_if.upli_completer_interface[i].req_attr                  = upli_if.upli_orignator_interface[i].req_attr;
      assign upli_if.upli_completer_interface[i].req_meta_data             = upli_if.upli_orignator_interface[i].req_meta_data;
      assign upli_if.upli_completer_interface[i].req_vc                    = upli_if.upli_orignator_interface[i].req_vc;
      assign upli_if.upli_completer_interface[i].req_pool                  = upli_if.upli_orignator_interface[i].req_pool;
      assign upli_if.upli_completer_interface[i].req_credit_init_done      = upli_if.upli_orignator_interface[i].req_credit_init_done;
      assign upli_if.upli_completer_interface[i].req_credit_vld            = upli_if.upli_orignator_interface[i].req_credit_vld;
      assign upli_if.upli_completer_interface[i].req_credit_pool           = upli_if.upli_orignator_interface[i].req_credit_pool;
      assign upli_if.upli_completer_interface[i].req_credit_port0_vc       = upli_if.upli_orignator_interface[i].req_credit_port0_vc;
      assign upli_if.upli_completer_interface[i].req_credit_port1_vc       = upli_if.upli_orignator_interface[i].req_credit_port1_vc;
      assign upli_if.upli_completer_interface[i].req_credit_port2_vc       = upli_if.upli_orignator_interface[i].req_credit_port2_vc;
      assign upli_if.upli_completer_interface[i].req_credit_port3_vc       = upli_if.upli_orignator_interface[i].req_credit_port3_vc;
      assign upli_if.upli_completer_interface[i].req_credit_port0_num      = upli_if.upli_orignator_interface[i].req_credit_port0_num;
      assign upli_if.upli_completer_interface[i].req_credit_port1_num      = upli_if.upli_orignator_interface[i].req_credit_port1_num;
      assign upli_if.upli_completer_interface[i].req_credit_port2_num      = upli_if.upli_orignator_interface[i].req_credit_port2_num;
      assign upli_if.upli_completer_interface[i].req_credit_port3_num      = upli_if.upli_orignator_interface[i].req_credit_port3_num;
      assign upli_if.upli_completer_interface[i].req_vld_parity            = upli_if.upli_orignator_interface[i].req_vld_parity;
      assign upli_if.upli_completer_interface[i].req_addr_parity           = upli_if.upli_orignator_interface[i].req_addr_parity;
      assign upli_if.upli_completer_interface[i].req_parity                = upli_if.upli_orignator_interface[i].req_parity;
      assign upli_if.upli_completer_interface[i].req_credit_vld_parity     = upli_if.upli_orignator_interface[i].req_credit_vld_parity;
      assign upli_if.upli_completer_interface[i].req_credit_parity         = upli_if.upli_orignator_interface[i].req_credit_parity;

      // ============================================================
      // Originator Data Channel (Originator → Completer)
      // ============================================================
      assign upli_if.upli_completer_interface[i].orig_data_vld             = upli_if.upli_orignator_interface[i].orig_data_vld;
      assign upli_if.upli_completer_interface[i].orig_data_port_id         = upli_if.upli_orignator_interface[i].orig_data_port_id;
      assign upli_if.upli_completer_interface[i].orig_data                 = upli_if.upli_orignator_interface[i].orig_data;
      assign upli_if.upli_completer_interface[i].orig_data_byte_en         = upli_if.upli_orignator_interface[i].orig_data_byte_en;
      assign upli_if.upli_completer_interface[i].orig_data_offset          = upli_if.upli_orignator_interface[i].orig_data_offset;
      assign upli_if.upli_completer_interface[i].orig_data_last            = upli_if.upli_orignator_interface[i].orig_data_last;
      assign upli_if.upli_completer_interface[i].orig_data_error           = upli_if.upli_orignator_interface[i].orig_data_error;
      assign upli_if.upli_completer_interface[i].orig_data_vc              = upli_if.upli_orignator_interface[i].orig_data_vc;
      assign upli_if.upli_completer_interface[i].orig_data_pool            = upli_if.upli_orignator_interface[i].orig_data_pool;
      assign upli_if.upli_completer_interface[i].orig_data_credit_init_done= upli_if.upli_orignator_interface[i].orig_data_credit_init_done;
      assign upli_if.upli_completer_interface[i].orig_data_credit_vld      = upli_if.upli_orignator_interface[i].orig_data_credit_vld;
      assign upli_if.upli_completer_interface[i].orig_data_credit_pool     = upli_if.upli_orignator_interface[i].orig_data_credit_pool;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port0_vc = upli_if.upli_orignator_interface[i].orig_data_credit_port0_vc;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port1_vc = upli_if.upli_orignator_interface[i].orig_data_credit_port1_vc;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port2_vc = upli_if.upli_orignator_interface[i].orig_data_credit_port2_vc;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port3_vc = upli_if.upli_orignator_interface[i].orig_data_credit_port3_vc;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port0_num= upli_if.upli_orignator_interface[i].orig_data_credit_port0_num;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port1_num= upli_if.upli_orignator_interface[i].orig_data_credit_port1_num;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port2_num= upli_if.upli_orignator_interface[i].orig_data_credit_port2_num;
      assign upli_if.upli_completer_interface[i].orig_data_credit_port3_num= upli_if.upli_orignator_interface[i].orig_data_credit_port3_num;
      assign upli_if.upli_completer_interface[i].orig_data_vld_parity      = upli_if.upli_orignator_interface[i].orig_data_vld_parity;
      assign upli_if.upli_completer_interface[i].orig_data_parity          = upli_if.upli_orignator_interface[i].orig_data_parity;
      assign upli_if.upli_completer_interface[i].orig_data_byte_en_parity  = upli_if.upli_orignator_interface[i].orig_data_byte_en_parity;
      assign upli_if.upli_completer_interface[i].orig_data_fields_parity   = upli_if.upli_orignator_interface[i].orig_data_fields_parity;
      assign upli_if.upli_completer_interface[i].orig_data_credit_vld_parity= upli_if.upli_orignator_interface[i].orig_data_credit_vld_parity;
      assign upli_if.upli_completer_interface[i].orig_data_credit_parity   = upli_if.upli_orignator_interface[i].orig_data_credit_parity;

      // ============================================================
      // Write Response Channel (Completer → Originator)
      // ============================================================
      assign upli_if.upli_orignator_interface[i].wr_rsp_vld               = upli_if.upli_completer_interface[i].wr_rsp_vld;
      assign upli_if.upli_orignator_interface[i].wr_rsp_port_id          = upli_if.upli_completer_interface[i].wr_rsp_port_id;
      assign upli_if.upli_orignator_interface[i].wr_rsp_auth_tag         = upli_if.upli_completer_interface[i].wr_rsp_auth_tag;
      assign upli_if.upli_orignator_interface[i].wr_rsp_src_phys_acc_id  = upli_if.upli_completer_interface[i].wr_rsp_src_phys_acc_id;
      assign upli_if.upli_orignator_interface[i].wr_rsp_dst_phys_acc_id  = upli_if.upli_completer_interface[i].wr_rsp_dst_phys_acc_id;
      assign upli_if.upli_orignator_interface[i].wr_rsp_tag              = upli_if.upli_completer_interface[i].wr_rsp_tag;
      assign upli_if.upli_orignator_interface[i].wr_rsp_status           = upli_if.upli_completer_interface[i].wr_rsp_status;
      assign upli_if.upli_orignator_interface[i].wr_rsp_vc               = upli_if.upli_completer_interface[i].wr_rsp_vc;
      assign upli_if.upli_orignator_interface[i].wr_rsp_pool             = upli_if.upli_completer_interface[i].wr_rsp_pool;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_init_done = upli_if.upli_completer_interface[i].wr_rsp_credit_init_done;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_vld       = upli_if.upli_completer_interface[i].wr_rsp_credit_vld;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_pool      = upli_if.upli_completer_interface[i].wr_rsp_credit_pool;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port0_vc  = upli_if.upli_completer_interface[i].wr_rsp_credit_port0_vc;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port1_vc  = upli_if.upli_completer_interface[i].wr_rsp_credit_port1_vc;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port2_vc  = upli_if.upli_completer_interface[i].wr_rsp_credit_port2_vc;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port3_vc  = upli_if.upli_completer_interface[i].wr_rsp_credit_port3_vc;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port0_num = upli_if.upli_completer_interface[i].wr_rsp_credit_port0_num;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port1_num = upli_if.upli_completer_interface[i].wr_rsp_credit_port1_num;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port2_num = upli_if.upli_completer_interface[i].wr_rsp_credit_port2_num;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_port3_num = upli_if.upli_completer_interface[i].wr_rsp_credit_port3_num;
      assign upli_if.upli_orignator_interface[i].wr_rsp_vld_parity       = upli_if.upli_completer_interface[i].wr_rsp_vld_parity;
      assign upli_if.upli_orignator_interface[i].wr_rsp_parity           = upli_if.upli_completer_interface[i].wr_rsp_parity;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_vld_parity= upli_if.upli_completer_interface[i].wr_rsp_credit_vld_parity;
      assign upli_if.upli_orignator_interface[i].wr_rsp_credit_parity    = upli_if.upli_completer_interface[i].wr_rsp_credit_parity;

      // ============================================================
      // Read Response & Data Channel (Completer → Originator)
      // ============================================================
      assign upli_if.upli_orignator_interface[i].rd_rsp_vld               = upli_if.upli_completer_interface[i].rd_rsp_vld;
      assign upli_if.upli_orignator_interface[i].rd_rsp_port_id          = upli_if.upli_completer_interface[i].rd_rsp_port_id;
      assign upli_if.upli_orignator_interface[i].rd_rsp_auth_tag         = upli_if.upli_completer_interface[i].rd_rsp_auth_tag;
      assign upli_if.upli_orignator_interface[i].rd_rsp_src_phys_acc_id  = upli_if.upli_completer_interface[i].rd_rsp_src_phys_acc_id;
      assign upli_if.upli_orignator_interface[i].rd_rsp_dst_phys_acc_id  = upli_if.upli_completer_interface[i].rd_rsp_dst_phys_acc_id;
      assign upli_if.upli_orignator_interface[i].rd_rsp_tag              = upli_if.upli_completer_interface[i].rd_rsp_tag;
      assign upli_if.upli_orignator_interface[i].rd_rsp_num_beats        = upli_if.upli_completer_interface[i].rd_rsp_num_beats;
      assign upli_if.upli_orignator_interface[i].rd_rsp_data             = upli_if.upli_completer_interface[i].rd_rsp_data;
      assign upli_if.upli_orignator_interface[i].rd_rsp_status           = upli_if.upli_completer_interface[i].rd_rsp_status;
      assign upli_if.upli_orignator_interface[i].rd_rsp_offset           = upli_if.upli_completer_interface[i].rd_rsp_offset;
      assign upli_if.upli_orignator_interface[i].rd_rsp_last             = upli_if.upli_completer_interface[i].rd_rsp_last;
      assign upli_if.upli_orignator_interface[i].rd_rsp_data_error       = upli_if.upli_completer_interface[i].rd_rsp_data_error;
      assign upli_if.upli_orignator_interface[i].rd_rsp_vc               = upli_if.upli_completer_interface[i].rd_rsp_vc;
      assign upli_if.upli_orignator_interface[i].rd_rsp_pool             = upli_if.upli_completer_interface[i].rd_rsp_pool;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_init_done = upli_if.upli_completer_interface[i].rd_rsp_credit_init_done;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_vld       = upli_if.upli_completer_interface[i].rd_rsp_credit_vld;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_pool      = upli_if.upli_completer_interface[i].rd_rsp_credit_pool;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port0_vc  = upli_if.upli_completer_interface[i].rd_rsp_credit_port0_vc;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port1_vc  = upli_if.upli_completer_interface[i].rd_rsp_credit_port1_vc;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port2_vc  = upli_if.upli_completer_interface[i].rd_rsp_credit_port2_vc;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port3_vc  = upli_if.upli_completer_interface[i].rd_rsp_credit_port3_vc;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port0_num = upli_if.upli_completer_interface[i].rd_rsp_credit_port0_num;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port1_num = upli_if.upli_completer_interface[i].rd_rsp_credit_port1_num;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port2_num = upli_if.upli_completer_interface[i].rd_rsp_credit_port2_num;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_port3_num = upli_if.upli_completer_interface[i].rd_rsp_credit_port3_num;
      assign upli_if.upli_orignator_interface[i].rd_rsp_vld_parity       = upli_if.upli_completer_interface[i].rd_rsp_vld_parity;
      assign upli_if.upli_orignator_interface[i].rd_rsp_data_parity      = upli_if.upli_completer_interface[i].rd_rsp_data_parity;
      assign upli_if.upli_orignator_interface[i].rd_rsp_parity           = upli_if.upli_completer_interface[i].rd_rsp_parity;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_vld_parity= upli_if.upli_completer_interface[i].rd_rsp_credit_vld_parity;
      assign upli_if.upli_orignator_interface[i].rd_rsp_credit_parity    = upli_if.upli_completer_interface[i].rd_rsp_credit_parity;

    end
  endgenerate

endmodule

`endif // UPLI_HDL_WRAPPER_SV

