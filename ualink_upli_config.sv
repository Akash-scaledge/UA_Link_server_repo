

`ifndef UALINK_UPLI_CONFIG_SV
`define UALINK_UPLI_CONFIG_SV

class ualink_upli_config extends uvm_object;

  `uvm_object_utils(ualink_upli_config)

  // ============================================================
  // Misc Configurations
  // ============================================================

  // Configure Agent as Active or Passive
  bit is_active;

  // Configure Agent's bifurgation mode
  upli_bif_e bifurgation_mode;

  // Configure to send autmatic credits based on number of configured credits.
  bit send_credit_auto;

  // Maximum number of Request credit to send by Completer to Originator
  int unsigned max_number_of_pool_request_cmd_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH];

  // Maximum number of Request credit to send by Completer to Originator
  int unsigned max_number_of_vc_request_cmd_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0][`UPLI_MAX_REQ_VC_WIDTH-1:0];

  // Maximum number of Orignator Data credit to send by Completer to Originator
  int unsigned max_number_of_pool_orig_data_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0];

  // Maximum number of Orignator Data credit to send by Completer to Originator
  int unsigned max_number_of_vc_orig_data_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0][`UPLI_MAX_REQ_VC_WIDTH-1:0];

  // Maximum number of Write response credit to send by Originator to Completer.
  int unsigned max_number_of_pool_wr_rsp_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0];

  // Maximum number of Write response credit to send by Originator to Completer.
  int unsigned max_number_of_vc_wr_rsp_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0][`UPLI_MAX_REQ_VC_WIDTH-1:0];

  // Maximum number of Read response credit to send by Originator to Completer.
  int unsigned max_number_of_pool_rd_rsp_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0];

  // Maximum number of Read response credit to send by Originator to Completer.
  int unsigned max_number_of_vc_rd_rsp_credit[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0][`UPLI_MAX_REQ_VC_WIDTH-1:0];

  // Number of VC per port enabled
  int num_of_vc;

  // ============================================================
  // Request Channel Widths
  // ============================================================
  int unsigned req_port_id_width          = `UPLI_MAX_REQ_PORT_ID_WIDTH;
  int unsigned req_asi_width              = `UPLI_MAX_REQ_ASI_WIDTH;
  int unsigned req_auth_tag_width         = `UPLI_MAX_REQ_AUTH_TAG_WIDTH;
  int unsigned req_src_phys_acc_id_width  = `UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH;
  int unsigned req_dst_phys_acc_id_width  = `UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH;
  int unsigned req_tag_width              = `UPLI_MAX_REQ_TAG_WIDTH;
  int unsigned req_num_beats_width        = `UPLI_MAX_REQ_NUM_BEATS_WIDTH;
  int unsigned req_addr_width             = `UPLI_MAX_REQ_ADDR_WIDTH;
  int unsigned req_cmd_width              = `UPLI_MAX_REQ_CMD_WIDTH;
  int unsigned req_len_width              = `UPLI_MAX_REQ_LEN_WIDTH;
  int unsigned req_attr_width             = `UPLI_MAX_REQ_ATTR_WIDTH;
  int unsigned req_meta_data_width        = `UPLI_MAX_REQ_META_DATA_WIDTH;
  int unsigned req_vc_width               = `UPLI_MAX_REQ_VC_WIDTH;

  // Request Credit
  int unsigned req_credit_init_done_width = `UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH;
  int unsigned req_credit_vld_width       = `UPLI_MAX_REQ_CREDIT_VLD_WIDTH;
  int unsigned req_credit_pool_width      = `UPLI_MAX_REQ_CREDIT_POOL_WIDTH;
  int unsigned req_credit_port_vc_width   = `UPLI_MAX_REQ_CREDIT_PORT0_VC_WIDTH;
  int unsigned req_credit_port_num_width  = `UPLI_MAX_REQ_CREDIT_PORT0_NUM_WIDTH;

  // ============================================================
  // Originator Data Channel Widths
  // ============================================================
  int unsigned orig_data_port_id_width    = `UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH;
  int unsigned orig_data_width            = `UPLI_MAX_ORIG_DATA_WIDTH;
  int unsigned orig_data_byte_en_width    = (`UPLI_MAX_ORIG_DATA_WIDTH / 8);
  int unsigned orig_data_offset_width     = `UPLI_MAX_ORIG_DATA_OFFSET_WIDTH;
  int unsigned orig_data_vc_width         = `UPLI_MAX_ORIG_DATA_VC_WIDTH;

  // Originator Credit
  int unsigned orig_credit_init_done_width = `UPLI_MAX_ORIG_DATA_CREDIT_INIT_DONE_WIDTH;
  int unsigned orig_credit_vld_width       = `UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH;
  int unsigned orig_credit_pool_width      = `UPLI_MAX_ORIG_DATA_CREDIT_POOL_WIDTH;
  int unsigned orig_credit_port_vc_width   = `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_VC_WIDTH;
  int unsigned orig_credit_port_num_width  = `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_NUM_WIDTH;

  // ============================================================
  // Write Response Channel Widths
  // ============================================================
  int unsigned wr_rsp_port_id_width       = `UPLI_MAX_WR_RSP_PORT_ID_WIDTH;
  int unsigned wr_rsp_auth_tag_width      = `UPLI_MAX_WR_RSP_AUTH_TAG_WIDTH;
  int unsigned wr_rsp_src_phys_acc_id_width = `UPLI_MAX_WR_RSP_SRC_PHYS_ACC_ID_WIDTH;
  int unsigned wr_rsp_dst_phys_acc_id_width = `UPLI_MAX_WR_RSP_DST_PHYS_ACC_ID_WIDTH;
  int unsigned wr_rsp_tag_width           = `UPLI_MAX_WR_RSP_TAG_WIDTH;
  int unsigned wr_rsp_status_width        = `UPLI_MAX_WR_RSP_STATUS_WIDTH;
  int unsigned wr_rsp_vc_width            = `UPLI_MAX_WR_RSP_VC_WIDTH;

  // Write Response Credit
  int unsigned wr_rsp_credit_init_done_width = `UPLI_MAX_WR_RSP_CREDIT_INIT_DONE_WIDTH;
  int unsigned wr_rsp_credit_vld_width       = `UPLI_MAX_WR_RSP_CREDIT_VLD_WIDTH;
  int unsigned wr_rsp_credit_pool_width      = `UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH;
  int unsigned wr_rsp_credit_port_vc_width   = `UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH;
  int unsigned wr_rsp_credit_port_num_width  = `UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH;

  // ============================================================
  // Read Response & Data Channel Widths
  // ============================================================
  int unsigned rd_rsp_port_id_width       = `UPLI_MAX_RD_RSP_PORT_ID_WIDTH;
  int unsigned rd_rsp_auth_tag_width      = `UPLI_MAX_RD_RSP_AUTH_TAG_WIDTH;
  int unsigned rd_rsp_src_phys_acc_id_width = `UPLI_MAX_RD_RSP_SRC_PHYS_ACC_ID_WIDTH;
  int unsigned rd_rsp_dst_phys_acc_id_width = `UPLI_MAX_RD_RSP_DST_PHYS_ACC_ID_WIDTH;
  int unsigned rd_rsp_tag_width           = `UPLI_MAX_RD_RSP_TAG_WIDTH;
  int unsigned rd_rsp_num_beats_width     = `UPLI_MAX_RD_RSP_NUM_BEATS_WIDTH;
  int unsigned rd_rsp_data_width          = `UPLI_MAX_RD_RSP_DATA_WIDTH;
  int unsigned rd_rsp_status_width        = `UPLI_MAX_RD_RSP_STATUS_WIDTH;
  int unsigned rd_rsp_offset_width        = `UPLI_MAX_RD_RSP_OFFSET_WIDTH;
  int unsigned rd_rsp_vc_width            = `UPLI_MAX_RD_RSP_VC_WIDTH;

  // Read Response Credit
  int unsigned rd_rsp_credit_init_done_width = `UPLI_MAX_RD_RSP_CREDIT_INIT_DONE_WIDTH;
  int unsigned rd_rsp_credit_vld_width       = `UPLI_MAX_RD_RSP_CREDIT_VLD_WIDTH;
  int unsigned rd_rsp_credit_pool_width      = `UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH;
  int unsigned rd_rsp_credit_port_vc_width   = `UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH;
  int unsigned rd_rsp_credit_port_num_width  = `UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH;

  // Reset 
  int unsigned num_clk_after_reset_assert;

  function new(string name = "ualink_upli_config");
    super.new(name);
  endfunction

  extern function void do_copy(uvm_object rhs);
  extern function string convert2string();
  extern function bit is_valid();

endclass: ualink_upli_config

// ============================================================
// do_copy
// ============================================================
function void ualink_upli_config::do_copy(uvm_object rhs);
  ualink_upli_config cfg_rhs;

  if (!$cast(cfg_rhs, rhs)) begin
    `uvm_fatal(get_type_name(),
      "do_copy: rhs is not of type ualink_upli_config")
  end

  // Misc
  is_active = cfg_rhs.is_active;
  bifurgation_mode = cfg_rhs.bifurgation_mode;
  send_credit_auto = cfg_rhs.send_credit_auto;
  max_number_of_pool_request_cmd_credit = cfg_rhs.max_number_of_pool_request_cmd_credit;
  max_number_of_pool_orig_data_credit = cfg_rhs.max_number_of_pool_orig_data_credit;
  max_number_of_pool_wr_rsp_credit = cfg_rhs.max_number_of_pool_wr_rsp_credit;
  max_number_of_pool_rd_rsp_credit = cfg_rhs.max_number_of_pool_rd_rsp_credit;
  max_number_of_vc_request_cmd_credit = cfg_rhs.max_number_of_vc_request_cmd_credit;
  max_number_of_vc_orig_data_credit = cfg_rhs.max_number_of_vc_orig_data_credit;
  max_number_of_vc_wr_rsp_credit = cfg_rhs.max_number_of_vc_wr_rsp_credit;
  max_number_of_vc_rd_rsp_credit = cfg_rhs.max_number_of_vc_rd_rsp_credit;

  // -------- Request
  req_port_id_width          = cfg_rhs.req_port_id_width;
  req_asi_width              = cfg_rhs.req_asi_width;
  req_auth_tag_width         = cfg_rhs.req_auth_tag_width;
  req_src_phys_acc_id_width  = cfg_rhs.req_src_phys_acc_id_width;
  req_dst_phys_acc_id_width  = cfg_rhs.req_dst_phys_acc_id_width;
  req_tag_width              = cfg_rhs.req_tag_width;
  req_num_beats_width        = cfg_rhs.req_num_beats_width;
  req_addr_width             = cfg_rhs.req_addr_width;
  req_cmd_width              = cfg_rhs.req_cmd_width;
  req_len_width              = cfg_rhs.req_len_width;
  req_attr_width             = cfg_rhs.req_attr_width;
  req_meta_data_width        = cfg_rhs.req_meta_data_width;
  req_vc_width               = cfg_rhs.req_vc_width;
  req_credit_init_done_width = cfg_rhs.req_credit_init_done_width;
  req_credit_vld_width       = cfg_rhs.req_credit_vld_width;
  req_credit_pool_width      = cfg_rhs.req_credit_pool_width;
  req_credit_port_vc_width   = cfg_rhs.req_credit_port_vc_width;
  req_credit_port_num_width  = cfg_rhs.req_credit_port_num_width;

  // -------- Originator
  orig_data_port_id_width    = cfg_rhs.orig_data_port_id_width;
  orig_data_width            = cfg_rhs.orig_data_width;
  orig_data_byte_en_width    = cfg_rhs.orig_data_byte_en_width;
  orig_data_offset_width     = cfg_rhs.orig_data_offset_width;
  orig_data_vc_width         = cfg_rhs.orig_data_vc_width;
  orig_credit_init_done_width = cfg_rhs.orig_credit_init_done_width;
  orig_credit_vld_width       = cfg_rhs.orig_credit_vld_width;
  orig_credit_pool_width      = cfg_rhs.orig_credit_pool_width;
  orig_credit_port_vc_width   = cfg_rhs.orig_credit_port_vc_width;
  orig_credit_port_num_width  = cfg_rhs.orig_credit_port_num_width;

  // -------- Write Response
  wr_rsp_port_id_width       = cfg_rhs.wr_rsp_port_id_width;
  wr_rsp_auth_tag_width      = cfg_rhs.wr_rsp_auth_tag_width;
  wr_rsp_src_phys_acc_id_width = cfg_rhs.wr_rsp_src_phys_acc_id_width;
  wr_rsp_dst_phys_acc_id_width = cfg_rhs.wr_rsp_dst_phys_acc_id_width;
  wr_rsp_tag_width           = cfg_rhs.wr_rsp_tag_width;
  wr_rsp_status_width        = cfg_rhs.wr_rsp_status_width;
  wr_rsp_vc_width            = cfg_rhs.wr_rsp_vc_width;
  wr_rsp_credit_init_done_width = cfg_rhs.wr_rsp_credit_init_done_width;
  wr_rsp_credit_vld_width       = cfg_rhs.wr_rsp_credit_vld_width;
  wr_rsp_credit_pool_width      = cfg_rhs.wr_rsp_credit_pool_width;
  wr_rsp_credit_port_vc_width   = cfg_rhs.wr_rsp_credit_port_vc_width;
  wr_rsp_credit_port_num_width  = cfg_rhs.wr_rsp_credit_port_num_width;

  // -------- Read Response
  rd_rsp_port_id_width       = cfg_rhs.rd_rsp_port_id_width;
  rd_rsp_auth_tag_width      = cfg_rhs.rd_rsp_auth_tag_width;
  rd_rsp_src_phys_acc_id_width = cfg_rhs.rd_rsp_src_phys_acc_id_width;
  rd_rsp_dst_phys_acc_id_width = cfg_rhs.rd_rsp_dst_phys_acc_id_width;
  rd_rsp_tag_width           = cfg_rhs.rd_rsp_tag_width;
  rd_rsp_num_beats_width     = cfg_rhs.rd_rsp_num_beats_width;
  rd_rsp_data_width          = cfg_rhs.rd_rsp_data_width;
  rd_rsp_status_width        = cfg_rhs.rd_rsp_status_width;
  rd_rsp_offset_width        = cfg_rhs.rd_rsp_offset_width;
  rd_rsp_vc_width            = cfg_rhs.rd_rsp_vc_width;
  rd_rsp_credit_init_done_width = cfg_rhs.rd_rsp_credit_init_done_width;
  rd_rsp_credit_vld_width       = cfg_rhs.rd_rsp_credit_vld_width;
  rd_rsp_credit_pool_width      = cfg_rhs.rd_rsp_credit_pool_width;
  rd_rsp_credit_port_vc_width   = cfg_rhs.rd_rsp_credit_port_vc_width;
  rd_rsp_credit_port_num_width  = cfg_rhs.rd_rsp_credit_port_num_width;

  num_clk_after_reset_assert    = cfg_rhs.num_clk_after_reset_assert;

endfunction

function string ualink_upli_config::convert2string();
  string s;

  s = "\n============================================================\n";
  s = {s, "        U A L I N K   C O N F I G : ",
           get_full_name(), "\n"};
  s = {s, "============================================================\n"};

  s = {s, $sformatf("| is_active                    | %d |\n", is_active)};
  s = {s, $sformatf("| bifurgation_mode             | %s |\n", bifurgation_mode.name())};
  // ============================================================
  // Request Channel
  // ============================================================
  s = {s, "\n[ REQUEST CHANNEL WIDTHS ]\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, "| Field                                | Width |\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, $sformatf("| req_port_id_width                    | %5d |\n", req_port_id_width)};
  s = {s, $sformatf("| req_asi_width                        | %5d |\n", req_asi_width)};
  s = {s, $sformatf("| req_auth_tag_width                   | %5d |\n", req_auth_tag_width)};
  s = {s, $sformatf("| req_src_phys_acc_id_width            | %5d |\n", req_src_phys_acc_id_width)};
  s = {s, $sformatf("| req_dst_phys_acc_id_width            | %5d |\n", req_dst_phys_acc_id_width)};
  s = {s, $sformatf("| req_tag_width                        | %5d |\n", req_tag_width)};
  s = {s, $sformatf("| req_num_beats_width                  | %5d |\n", req_num_beats_width)};
  s = {s, $sformatf("| req_addr_width                       | %5d |\n", req_addr_width)};
  s = {s, $sformatf("| req_cmd_width                        | %5d |\n", req_cmd_width)};
  s = {s, $sformatf("| req_len_width                        | %5d |\n", req_len_width)};
  s = {s, $sformatf("| req_attr_width                       | %5d |\n", req_attr_width)};
  s = {s, $sformatf("| req_meta_data_width                  | %5d |\n", req_meta_data_width)};
  s = {s, $sformatf("| req_vc_width                         | %5d |\n", req_vc_width)};
  s = {s, $sformatf("| req_credit_init_done_width           | %5d |\n", req_credit_init_done_width)};
  s = {s, $sformatf("| req_credit_vld_width                 | %5d |\n", req_credit_vld_width)};
  s = {s, $sformatf("| req_credit_pool_width                | %5d |\n", req_credit_pool_width)};
  s = {s, $sformatf("| req_credit_port_vc_width             | %5d |\n", req_credit_port_vc_width)};
  s = {s, $sformatf("| req_credit_port_num_width            | %5d |\n", req_credit_port_num_width)};
  s = {s, "+--------------------------------------+-------+\n"};

  // ============================================================
  // Originator Data Channel
  // ============================================================
  s = {s, "\n[ ORIGINATOR DATA CHANNEL WIDTHS ]\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, "| Field                                | Width |\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, $sformatf("| orig_data_port_id_width              | %5d |\n", orig_data_port_id_width)};
  s = {s, $sformatf("| orig_data_width                      | %5d |\n", orig_data_width)};
  s = {s, $sformatf("| orig_data_byte_en_width              | %5d |\n", orig_data_byte_en_width)};
  s = {s, $sformatf("| orig_data_offset_width               | %5d |\n", orig_data_offset_width)};
  s = {s, $sformatf("| orig_data_vc_width                   | %5d |\n", orig_data_vc_width)};
  s = {s, $sformatf("| orig_credit_init_done_width          | %5d |\n", orig_credit_init_done_width)};
  s = {s, $sformatf("| orig_credit_vld_width                | %5d |\n", orig_credit_vld_width)};
  s = {s, $sformatf("| orig_credit_pool_width               | %5d |\n", orig_credit_pool_width)};
  s = {s, $sformatf("| orig_credit_port_vc_width            | %5d |\n", orig_credit_port_vc_width)};
  s = {s, $sformatf("| orig_credit_port_num_width           | %5d |\n", orig_credit_port_num_width)};
  s = {s, "+--------------------------------------+-------+\n"};

  // ============================================================
  // Write Response Channel
  // ============================================================
  s = {s, "\n[ WRITE RESPONSE CHANNEL WIDTHS ]\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, "| Field                                | Width |\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, $sformatf("| wr_rsp_port_id_width                 | %5d |\n", wr_rsp_port_id_width)};
  s = {s, $sformatf("| wr_rsp_auth_tag_width                | %5d |\n", wr_rsp_auth_tag_width)};
  s = {s, $sformatf("| wr_rsp_src_phys_acc_id_width         | %5d |\n", wr_rsp_src_phys_acc_id_width)};
  s = {s, $sformatf("| wr_rsp_dst_phys_acc_id_width         | %5d |\n", wr_rsp_dst_phys_acc_id_width)};
  s = {s, $sformatf("| wr_rsp_tag_width                     | %5d |\n", wr_rsp_tag_width)};
  s = {s, $sformatf("| wr_rsp_status_width                  | %5d |\n", wr_rsp_status_width)};
  s = {s, $sformatf("| wr_rsp_vc_width                      | %5d |\n", wr_rsp_vc_width)};
  s = {s, $sformatf("| wr_rsp_credit_init_done_width        | %5d |\n", wr_rsp_credit_init_done_width)};
  s = {s, $sformatf("| wr_rsp_credit_vld_width              | %5d |\n", wr_rsp_credit_vld_width)};
  s = {s, $sformatf("| wr_rsp_credit_pool_width             | %5d |\n", wr_rsp_credit_pool_width)};
  s = {s, $sformatf("| wr_rsp_credit_port_vc_width          | %5d |\n", wr_rsp_credit_port_vc_width)};
  s = {s, $sformatf("| wr_rsp_credit_port_num_width         | %5d |\n", wr_rsp_credit_port_num_width)};
  s = {s, "+--------------------------------------+-------+\n"};

  // ============================================================
  // Read Response & Data Channel
  // ============================================================
  s = {s, "\n[ READ RESPONSE & DATA CHANNEL WIDTHS ]\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, "| Field                                | Width |\n"};
  s = {s, "+--------------------------------------+-------+\n"};
  s = {s, $sformatf("| rd_rsp_port_id_width                 | %5d |\n", rd_rsp_port_id_width)};
  s = {s, $sformatf("| rd_rsp_auth_tag_width                | %5d |\n", rd_rsp_auth_tag_width)};
  s = {s, $sformatf("| rd_rsp_src_phys_acc_id_width         | %5d |\n", rd_rsp_src_phys_acc_id_width)};
  s = {s, $sformatf("| rd_rsp_dst_phys_acc_id_width         | %5d |\n", rd_rsp_dst_phys_acc_id_width)};
  s = {s, $sformatf("| rd_rsp_tag_width                     | %5d |\n", rd_rsp_tag_width)};
  s = {s, $sformatf("| rd_rsp_num_beats_width               | %5d |\n", rd_rsp_num_beats_width)};
  s = {s, $sformatf("| rd_rsp_data_width                    | %5d |\n", rd_rsp_data_width)};
  s = {s, $sformatf("| rd_rsp_status_width                  | %5d |\n", rd_rsp_status_width)};
  s = {s, $sformatf("| rd_rsp_offset_width                  | %5d |\n", rd_rsp_offset_width)};
  s = {s, $sformatf("| rd_rsp_vc_width                      | %5d |\n", rd_rsp_vc_width)};
  s = {s, $sformatf("| rd_rsp_credit_init_done_width        | %5d |\n", rd_rsp_credit_init_done_width)};
  s = {s, $sformatf("| rd_rsp_credit_vld_width              | %5d |\n", rd_rsp_credit_vld_width)};
  s = {s, $sformatf("| rd_rsp_credit_pool_width             | %5d |\n", rd_rsp_credit_pool_width)};
  s = {s, $sformatf("| rd_rsp_credit_port_vc_width          | %5d |\n", rd_rsp_credit_port_vc_width)};
  s = {s, $sformatf("| rd_rsp_credit_port_num_width         | %5d |\n", rd_rsp_credit_port_num_width)};
  s = {s, $sformatf("| num_clk_after_reset_assert           | %5d |\n", num_clk_after_reset_assert)};
  s = {s, "+--------------------------------------+-------+\n"};

  return s;
endfunction: convert2string

function bit ualink_upli_config::is_valid();

  // ============================================================
  // Request Channel
  // ============================================================
  if (req_port_id_width > `UPLI_MAX_REQ_PORT_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_port_id_width=%0d > UPLI_MAX_REQ_PORT_ID_WIDTH=%0d",
                         req_port_id_width, `UPLI_MAX_REQ_PORT_ID_WIDTH));
    return 0;
  end

  if (req_asi_width > `UPLI_MAX_REQ_ASI_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_asi_width=%0d > UPLI_MAX_REQ_ASI_WIDTH=%0d",
                         req_asi_width, `UPLI_MAX_REQ_ASI_WIDTH));
    return 0;
  end

  if (req_auth_tag_width > `UPLI_MAX_REQ_AUTH_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_auth_tag_width=%0d > UPLI_MAX_REQ_AUTH_TAG_WIDTH=%0d",
                         req_auth_tag_width, `UPLI_MAX_REQ_AUTH_TAG_WIDTH));
    return 0;
  end

  if (req_src_phys_acc_id_width > `UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_src_phys_acc_id_width=%0d > UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH=%0d",
                         req_src_phys_acc_id_width, `UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (req_dst_phys_acc_id_width > `UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_dst_phys_acc_id_width=%0d > UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH=%0d",
                         req_dst_phys_acc_id_width, `UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (req_tag_width > `UPLI_MAX_REQ_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_tag_width=%0d > UPLI_MAX_REQ_TAG_WIDTH=%0d",
                         req_tag_width, `UPLI_MAX_REQ_TAG_WIDTH));
    return 0;
  end

  if (req_num_beats_width > `UPLI_MAX_REQ_NUM_BEATS_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_num_beats_width=%0d > UPLI_MAX_REQ_NUM_BEATS_WIDTH=%0d",
                         req_num_beats_width, `UPLI_MAX_REQ_NUM_BEATS_WIDTH));
    return 0;
  end

  if (req_addr_width > `UPLI_MAX_REQ_ADDR_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_addr_width=%0d > UPLI_MAX_REQ_ADDR_WIDTH=%0d",
                         req_addr_width, `UPLI_MAX_REQ_ADDR_WIDTH));
    return 0;
  end

  if (req_cmd_width > `UPLI_MAX_REQ_CMD_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_cmd_width=%0d > UPLI_MAX_REQ_CMD_WIDTH=%0d",
                         req_cmd_width, `UPLI_MAX_REQ_CMD_WIDTH));
    return 0;
  end

  if (req_len_width > `UPLI_MAX_REQ_LEN_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_len_width=%0d > UPLI_MAX_REQ_LEN_WIDTH=%0d",
                         req_len_width, `UPLI_MAX_REQ_LEN_WIDTH));
    return 0;
  end

  if (req_attr_width > `UPLI_MAX_REQ_ATTR_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_attr_width=%0d > UPLI_MAX_REQ_ATTR_WIDTH=%0d",
                         req_attr_width, `UPLI_MAX_REQ_ATTR_WIDTH));
    return 0;
  end

  if (req_meta_data_width > `UPLI_MAX_REQ_META_DATA_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_meta_data_width=%0d > UPLI_MAX_REQ_META_DATA_WIDTH=%0d",
                         req_meta_data_width, `UPLI_MAX_REQ_META_DATA_WIDTH));
    return 0;
  end

  if (req_vc_width > `UPLI_MAX_REQ_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_vc_width=%0d > UPLI_MAX_REQ_VC_WIDTH=%0d",
                         req_vc_width, `UPLI_MAX_REQ_VC_WIDTH));
    return 0;
  end

  // ----------------------------
  // Request Credit
  // ----------------------------
  if (req_credit_init_done_width > `UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_credit_init_done_width=%0d > UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH=%0d",
                         req_credit_init_done_width, `UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH));
    return 0;
  end

  if (req_credit_vld_width > `UPLI_MAX_REQ_CREDIT_VLD_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_credit_vld_width=%0d > UPLI_MAX_REQ_CREDIT_VLD_WIDTH=%0d",
                         req_credit_vld_width, `UPLI_MAX_REQ_CREDIT_VLD_WIDTH));
    return 0;
  end

  if (req_credit_pool_width > `UPLI_MAX_REQ_CREDIT_POOL_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_credit_pool_width=%0d > UPLI_MAX_REQ_CREDIT_POOL_WIDTH=%0d",
                         req_credit_pool_width, `UPLI_MAX_REQ_CREDIT_POOL_WIDTH));
    return 0;
  end

  if (req_credit_port_vc_width > `UPLI_MAX_REQ_CREDIT_PORT0_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_credit_port_vc_width=%0d > UPLI_MAX_REQ_CREDIT_PORT0_VC_WIDTH=%0d",
                         req_credit_port_vc_width, `UPLI_MAX_REQ_CREDIT_PORT0_VC_WIDTH));
    return 0;
  end

  if (req_credit_port_num_width > `UPLI_MAX_REQ_CREDIT_PORT0_NUM_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("req_credit_port_num_width=%0d > UPLI_MAX_REQ_CREDIT_PORT0_NUM_WIDTH=%0d",
                         req_credit_port_num_width, `UPLI_MAX_REQ_CREDIT_PORT0_NUM_WIDTH));
    return 0;
  end

  // ============================================================
  // Originator Data + Credit
  // ============================================================
  if (orig_data_port_id_width > `UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_data_port_id_width=%0d > UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH=%0d",
                         orig_data_port_id_width, `UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH));
    return 0;
  end

  if (orig_data_width > `UPLI_MAX_ORIG_DATA_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_data_width=%0d > UPLI_MAX_ORIG_DATA_WIDTH=%0d",
                         orig_data_width, `UPLI_MAX_ORIG_DATA_WIDTH));
    return 0;
  end

  if (orig_data_offset_width > `UPLI_MAX_ORIG_DATA_OFFSET_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_data_offset_width=%0d > UPLI_MAX_ORIG_DATA_OFFSET_WIDTH=%0d",
                         orig_data_offset_width, `UPLI_MAX_ORIG_DATA_OFFSET_WIDTH));
    return 0;
  end

  if (orig_data_vc_width > `UPLI_MAX_ORIG_DATA_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_data_vc_width=%0d > UPLI_MAX_ORIG_DATA_VC_WIDTH=%0d",
                         orig_data_vc_width, `UPLI_MAX_ORIG_DATA_VC_WIDTH));
    return 0;
  end

  if (orig_credit_init_done_width > `UPLI_MAX_ORIG_DATA_CREDIT_INIT_DONE_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_credit_init_done_width=%0d > UPLI_MAX_ORIG_DATA_CREDIT_INIT_DONE_WIDTH=%0d",
                         orig_credit_init_done_width, `UPLI_MAX_ORIG_DATA_CREDIT_INIT_DONE_WIDTH));
    return 0;
  end

  if (orig_credit_vld_width > `UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_credit_vld_width=%0d > UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH=%0d",
                         orig_credit_vld_width, `UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH));
    return 0;
  end

  if (orig_credit_pool_width > `UPLI_MAX_ORIG_DATA_CREDIT_POOL_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_credit_pool_width=%0d > UPLI_MAX_ORIG_DATA_CREDIT_POOL_WIDTH=%0d",
                         orig_credit_pool_width, `UPLI_MAX_ORIG_DATA_CREDIT_POOL_WIDTH));
    return 0;
  end

  if (orig_credit_port_vc_width > `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_credit_port_vc_width=%0d > UPLI_MAX_ORIG_DATA_CREDIT_PORT0_VC_WIDTH=%0d",
                         orig_credit_port_vc_width, `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_VC_WIDTH));
    return 0;
  end

  if (orig_credit_port_num_width > `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_NUM_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("orig_credit_port_num_width=%0d > UPLI_MAX_ORIG_DATA_CREDIT_PORT0_NUM_WIDTH=%0d",
                         orig_credit_port_num_width, `UPLI_MAX_ORIG_DATA_CREDIT_PORT0_NUM_WIDTH));
    return 0;
  end

  // ============================================================
  // Write Response + Credit
  // ============================================================
  if (wr_rsp_port_id_width > `UPLI_MAX_WR_RSP_PORT_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_port_id_width=%0d > UPLI_MAX_WR_RSP_PORT_ID_WIDTH=%0d",
                         wr_rsp_port_id_width, `UPLI_MAX_WR_RSP_PORT_ID_WIDTH));
    return 0;
  end

  if (wr_rsp_auth_tag_width > `UPLI_MAX_WR_RSP_AUTH_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_auth_tag_width=%0d > UPLI_MAX_WR_RSP_AUTH_TAG_WIDTH=%0d",
                         wr_rsp_auth_tag_width, `UPLI_MAX_WR_RSP_AUTH_TAG_WIDTH));
    return 0;
  end

  if (wr_rsp_src_phys_acc_id_width > `UPLI_MAX_WR_RSP_SRC_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_src_phys_acc_id_width=%0d > UPLI_MAX_WR_RSP_SRC_PHYS_ACC_ID_WIDTH=%0d",
                         wr_rsp_src_phys_acc_id_width, `UPLI_MAX_WR_RSP_SRC_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (wr_rsp_dst_phys_acc_id_width > `UPLI_MAX_WR_RSP_DST_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_dst_phys_acc_id_width=%0d > UPLI_MAX_WR_RSP_DST_PHYS_ACC_ID_WIDTH=%0d",
                         wr_rsp_dst_phys_acc_id_width, `UPLI_MAX_WR_RSP_DST_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (wr_rsp_tag_width > `UPLI_MAX_WR_RSP_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_tag_width=%0d > UPLI_MAX_WR_RSP_TAG_WIDTH=%0d",
                         wr_rsp_tag_width, `UPLI_MAX_WR_RSP_TAG_WIDTH));
    return 0;
  end

  if (wr_rsp_status_width > `UPLI_MAX_WR_RSP_STATUS_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_status_width=%0d > UPLI_MAX_WR_RSP_STATUS_WIDTH=%0d",
                         wr_rsp_status_width, `UPLI_MAX_WR_RSP_STATUS_WIDTH));
    return 0;
  end

  if (wr_rsp_vc_width > `UPLI_MAX_WR_RSP_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_vc_width=%0d > UPLI_MAX_WR_RSP_VC_WIDTH=%0d",
                         wr_rsp_vc_width, `UPLI_MAX_WR_RSP_VC_WIDTH));
    return 0;
  end

  if (wr_rsp_credit_init_done_width > `UPLI_MAX_WR_RSP_CREDIT_INIT_DONE_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_credit_init_done_width=%0d > UPLI_MAX_WR_RSP_CREDIT_INIT_DONE_WIDTH=%0d",
                         wr_rsp_credit_init_done_width, `UPLI_MAX_WR_RSP_CREDIT_INIT_DONE_WIDTH));
    return 0;
  end

  if (wr_rsp_credit_vld_width > `UPLI_MAX_WR_RSP_CREDIT_VLD_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_credit_vld_width=%0d > UPLI_MAX_WR_RSP_CREDIT_VLD_WIDTH=%0d",
                         wr_rsp_credit_vld_width, `UPLI_MAX_WR_RSP_CREDIT_VLD_WIDTH));
    return 0;
  end

  if (wr_rsp_credit_pool_width > `UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_credit_pool_width=%0d > UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH=%0d",
                         wr_rsp_credit_pool_width, `UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH));
    return 0;
  end

  if (wr_rsp_credit_port_vc_width > `UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_credit_port_vc_width=%0d > UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH=%0d",
                         wr_rsp_credit_port_vc_width, `UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH));
    return 0;
  end

  if (wr_rsp_credit_port_num_width > `UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("wr_rsp_credit_port_num_width=%0d > UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH=%0d",
                         wr_rsp_credit_port_num_width, `UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH));
    return 0;
  end

  // ============================================================
  // Read Response + Credit
  // ============================================================
  if (rd_rsp_port_id_width > `UPLI_MAX_RD_RSP_PORT_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_port_id_width=%0d > UPLI_MAX_RD_RSP_PORT_ID_WIDTH=%0d",
                         rd_rsp_port_id_width, `UPLI_MAX_RD_RSP_PORT_ID_WIDTH));
    return 0;
  end

  if (rd_rsp_auth_tag_width > `UPLI_MAX_RD_RSP_AUTH_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_auth_tag_width=%0d > UPLI_MAX_RD_RSP_AUTH_TAG_WIDTH=%0d",
                         rd_rsp_auth_tag_width, `UPLI_MAX_RD_RSP_AUTH_TAG_WIDTH));
    return 0;
  end

  if (rd_rsp_src_phys_acc_id_width > `UPLI_MAX_RD_RSP_SRC_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_src_phys_acc_id_width=%0d > UPLI_MAX_RD_RSP_SRC_PHYS_ACC_ID_WIDTH=%0d",
                         rd_rsp_src_phys_acc_id_width, `UPLI_MAX_RD_RSP_SRC_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (rd_rsp_dst_phys_acc_id_width > `UPLI_MAX_RD_RSP_DST_PHYS_ACC_ID_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_dst_phys_acc_id_width=%0d > UPLI_MAX_RD_RSP_DST_PHYS_ACC_ID_WIDTH=%0d",
                         rd_rsp_dst_phys_acc_id_width, `UPLI_MAX_RD_RSP_DST_PHYS_ACC_ID_WIDTH));
    return 0;
  end

  if (rd_rsp_tag_width > `UPLI_MAX_RD_RSP_TAG_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_tag_width=%0d > UPLI_MAX_RD_RSP_TAG_WIDTH=%0d",
                         rd_rsp_tag_width, `UPLI_MAX_RD_RSP_TAG_WIDTH));
    return 0;
  end

  if (rd_rsp_num_beats_width > `UPLI_MAX_RD_RSP_NUM_BEATS_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_num_beats_width=%0d > UPLI_MAX_RD_RSP_NUM_BEATS_WIDTH=%0d",
                         rd_rsp_num_beats_width, `UPLI_MAX_RD_RSP_NUM_BEATS_WIDTH));
    return 0;
  end

  if (rd_rsp_data_width > `UPLI_MAX_RD_RSP_DATA_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_data_width=%0d > UPLI_MAX_RD_RSP_DATA_WIDTH=%0d",
                         rd_rsp_data_width, `UPLI_MAX_RD_RSP_DATA_WIDTH));
    return 0;
  end

  if (rd_rsp_status_width > `UPLI_MAX_RD_RSP_STATUS_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_status_width=%0d > UPLI_MAX_RD_RSP_STATUS_WIDTH=%0d",
                         rd_rsp_status_width, `UPLI_MAX_RD_RSP_STATUS_WIDTH));
    return 0;
  end

  if (rd_rsp_offset_width > `UPLI_MAX_RD_RSP_OFFSET_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_offset_width=%0d > UPLI_MAX_RD_RSP_OFFSET_WIDTH=%0d",
                         rd_rsp_offset_width, `UPLI_MAX_RD_RSP_OFFSET_WIDTH));
    return 0;
  end

  if (rd_rsp_vc_width > `UPLI_MAX_RD_RSP_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_vc_width=%0d > UPLI_MAX_RD_RSP_VC_WIDTH=%0d",
                         rd_rsp_vc_width, `UPLI_MAX_RD_RSP_VC_WIDTH));
    return 0;
  end

  if (rd_rsp_credit_init_done_width > `UPLI_MAX_RD_RSP_CREDIT_INIT_DONE_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_credit_init_done_width=%0d > UPLI_MAX_RD_RSP_CREDIT_INIT_DONE_WIDTH=%0d",
                         rd_rsp_credit_init_done_width, `UPLI_MAX_RD_RSP_CREDIT_INIT_DONE_WIDTH));
    return 0;
  end

  if (rd_rsp_credit_vld_width > `UPLI_MAX_RD_RSP_CREDIT_VLD_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_credit_vld_width=%0d > UPLI_MAX_RD_RSP_CREDIT_VLD_WIDTH=%0d",
                         rd_rsp_credit_vld_width, `UPLI_MAX_RD_RSP_CREDIT_VLD_WIDTH));
    return 0;
  end

  if (rd_rsp_credit_pool_width > `UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_credit_pool_width=%0d > UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH=%0d",
                         rd_rsp_credit_pool_width, `UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH));
    return 0;
  end

  if (rd_rsp_credit_port_vc_width > `UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_credit_port_vc_width=%0d > UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH=%0d",
                         rd_rsp_credit_port_vc_width, `UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH));
    return 0;
  end

  if (rd_rsp_credit_port_num_width > `UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH)  begin
    `uvm_error($sformatf("%0s | is_valid CFG", get_full_name()),
               $sformatf("rd_rsp_credit_port_num_width=%0d > UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH=%0d",
                         rd_rsp_credit_port_num_width, `UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH));
    return 0;
  end

  return 1;

endfunction: is_valid

`endif // UALINK_UPLI_CONFIG_SV
