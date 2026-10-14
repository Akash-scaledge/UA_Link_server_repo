`ifndef UALINK_UPLI_TRANSACTION
`define UALINK_UPLI_TRANSACTION

class ualink_upli_transaction extends uvm_sequence_item;

  // =========================================================
  // Request Channel
  // =========================================================
  rand bit                                                       req_vld;
  rand bit [`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0]                req_port_id;
  rand bit [`UPLI_MAX_REQ_ASI_WIDTH-1:0]                    req_asi;
  rand bit [`UPLI_MAX_REQ_AUTH_TAG_WIDTH-1:0]               req_auth_tag;
  rand bit [`UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH-1:0]        req_src_phys_acc_id;
  rand bit [`UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH-1:0]        req_dst_phys_acc_id;
  rand bit [`UPLI_MAX_REQ_TAG_WIDTH-1:0]                    req_tag;
  rand bit [`UPLI_MAX_REQ_NUM_BEATS_WIDTH-1:0]              req_num_beats;
  rand bit [`UPLI_MAX_REQ_ADDR_WIDTH-1:0]                   req_addr;
  rand upli_reqcmd_e                                        req_cmd;
  rand bit [`UPLI_MAX_REQ_LEN_WIDTH-1:0]                    req_len;
  rand bit [`UPLI_MAX_REQ_ATTR_WIDTH-1:0]                   req_attr;
  rand bit [`UPLI_MAX_REQ_META_DATA_WIDTH-1:0]              req_meta_data;
  rand bit [`UPLI_MAX_REQ_VC_WIDTH-1:0]                     req_vc;
  rand bit                                                  req_pool;

  bit [`UPLI_MAX_REQ_CREDIT_INIT_DONE_WIDTH-1:0]            req_credit_init_done;
  bit [`UPLI_MAX_REQ_CREDIT_VLD_WIDTH-1:0]                  req_credit_vld;
  bit [`UPLI_MAX_REQ_CREDIT_POOL_WIDTH-1:0]                 req_credit_pool;
  bit [`UPLI_MAX_REQ_CREDIT_PORT0_VC_WIDTH-1:0]             req_credit_port0_vc;
  bit [`UPLI_MAX_REQ_CREDIT_PORT1_VC_WIDTH-1:0]             req_credit_port1_vc;
  bit [`UPLI_MAX_REQ_CREDIT_PORT2_VC_WIDTH-1:0]             req_credit_port2_vc;
  bit [`UPLI_MAX_REQ_CREDIT_PORT3_VC_WIDTH-1:0]             req_credit_port3_vc;
  bit [`UPLI_MAX_REQ_CREDIT_PORT0_NUM_WIDTH-1:0]            req_credit_port0_num;
  bit [`UPLI_MAX_REQ_CREDIT_PORT1_NUM_WIDTH-1:0]            req_credit_port1_num;
  bit [`UPLI_MAX_REQ_CREDIT_PORT2_NUM_WIDTH-1:0]            req_credit_port2_num;
  bit [`UPLI_MAX_REQ_CREDIT_PORT3_NUM_WIDTH-1:0]            req_credit_port3_num;

  bit                                                       req_vld_parity;
  bit                                                       req_addr_parity;
  bit                                                       req_parity;
  bit                                                       req_credit_vld_parity;
  bit                                                       req_credit_parity;

  // =========================================================
  // Originator Data Channel (Dynamic beats, max 4)
  // =========================================================
  rand bit                                                       orig_data_vld;
  rand bit [`UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH-1:0]          orig_data_port_id;
  rand bit [`UPLI_MAX_ORIG_DATA_WIDTH-1:0]                  orig_data[$]; // beats
  rand bit [(`UPLI_MAX_ORIG_DATA_WIDTH/8)-1:0]              orig_data_byte_en[$];
  rand bit [`UPLI_MAX_ORIG_DATA_OFFSET_WIDTH-1:0]           orig_data_offset;
  rand bit                                                  orig_data_last;
  rand bit                                                  orig_data_error;
  rand bit [`UPLI_MAX_ORIG_DATA_VC_WIDTH-1:0]               orig_data_vc;
  rand bit                                                  orig_data_pool;

  bit [`UPLI_MAX_ORIG_DATA_CREDIT_INIT_DONE_WIDTH-1:0]      orig_data_credit_init_done;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH-1:0]            orig_data_credit_vld;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_POOL_WIDTH-1:0]           orig_data_credit_pool;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT0_VC_WIDTH-1:0]       orig_data_credit_port0_vc;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT1_VC_WIDTH-1:0]       orig_data_credit_port1_vc;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT2_VC_WIDTH-1:0]       orig_data_credit_port2_vc;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT3_VC_WIDTH-1:0]       orig_data_credit_port3_vc;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT0_NUM_WIDTH-1:0]      orig_data_credit_port0_num;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT1_NUM_WIDTH-1:0]      orig_data_credit_port1_num;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT2_NUM_WIDTH-1:0]      orig_data_credit_port2_num;
  bit [`UPLI_MAX_ORIG_DATA_CREDIT_PORT3_NUM_WIDTH-1:0]      orig_data_credit_port3_num;

  bit                                                       orig_data_vld_parity;
  bit                                                       orig_data_parity;
  bit                                                       orig_data_byte_en_parity;
  bit                                                       orig_data_fields_parity;
  bit                                                       orig_data_credit_vld_parity;
  bit                                                       orig_data_credit_parity;

  // =========================================================
  // Write Response Channel
  // =========================================================
  bit                                                       wr_rsp_vld;
  rand bit [`UPLI_MAX_WR_RSP_PORT_ID_WIDTH-1:0]             wr_rsp_port_id;
  rand bit [`UPLI_MAX_WR_RSP_AUTH_TAG_WIDTH-1:0]            wr_rsp_auth_tag;
  rand bit [`UPLI_MAX_WR_RSP_SRC_PHYS_ACC_ID_WIDTH-1:0]     wr_rsp_src_phys_acc_id;
  rand bit [`UPLI_MAX_WR_RSP_DST_PHYS_ACC_ID_WIDTH-1:0]     wr_rsp_dst_phys_acc_id;
  rand bit [`UPLI_MAX_WR_RSP_TAG_WIDTH-1:0]                 wr_rsp_tag;
  rand bit [`UPLI_MAX_WR_RSP_STATUS_WIDTH-1:0]              wr_rsp_status;
  rand bit [`UPLI_MAX_WR_RSP_VC_WIDTH-1:0]                  wr_rsp_vc;
  rand bit                                                  wr_rsp_pool;

  bit [`UPLI_MAX_WR_RSP_CREDIT_INIT_DONE_WIDTH-1:0]         wr_rsp_credit_init_done;
  bit [`UPLI_MAX_WR_RSP_CREDIT_VLD_WIDTH-1:0]               wr_rsp_credit_vld;
  bit [`UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH-1:0]              wr_rsp_credit_pool;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH-1:0]          wr_rsp_credit_port0_vc;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT1_VC_WIDTH-1:0]          wr_rsp_credit_port1_vc;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT2_VC_WIDTH-1:0]          wr_rsp_credit_port2_vc;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT3_VC_WIDTH-1:0]          wr_rsp_credit_port3_vc;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH-1:0]         wr_rsp_credit_port0_num;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT1_NUM_WIDTH-1:0]         wr_rsp_credit_port1_num;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT2_NUM_WIDTH-1:0]         wr_rsp_credit_port2_num;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT3_NUM_WIDTH-1:0]         wr_rsp_credit_port3_num;

  bit                                                       wr_rsp_vld_parity;
  bit                                                       wr_rsp_parity;
  bit                                                       wr_rsp_credit_vld_parity;
  bit                                                       wr_rsp_credit_parity;

  // =========================================================
  // Read Response + Data Channel (Dynamic beats, max 4)
  // =========================================================
  bit                                                       rd_rsp_vld;
  rand bit [`UPLI_MAX_RD_RSP_PORT_ID_WIDTH-1:0]             rd_rsp_port_id;
  rand bit [`UPLI_MAX_RD_RSP_AUTH_TAG_WIDTH-1:0]            rd_rsp_auth_tag;
  rand bit [`UPLI_MAX_RD_RSP_SRC_PHYS_ACC_ID_WIDTH-1:0]     rd_rsp_src_phys_acc_id;
  rand bit [`UPLI_MAX_RD_RSP_DST_PHYS_ACC_ID_WIDTH-1:0]     rd_rsp_dst_phys_acc_id;
  rand bit [`UPLI_MAX_RD_RSP_TAG_WIDTH-1:0]                 rd_rsp_tag;
  rand bit [`UPLI_MAX_RD_RSP_NUM_BEATS_WIDTH-1:0]           rd_rsp_num_beats;
  rand bit [`UPLI_MAX_RD_RSP_DATA_WIDTH-1:0]                rd_rsp_data[]; // beats
  rand bit [`UPLI_MAX_RD_RSP_STATUS_WIDTH-1:0]              rd_rsp_status;
  rand bit [`UPLI_MAX_RD_RSP_OFFSET_WIDTH-1:0]              rd_rsp_offset;
  rand bit                                                  rd_rsp_last;
  rand bit                                                  rd_rsp_data_error;
  rand bit [`UPLI_MAX_RD_RSP_VC_WIDTH-1:0]                  rd_rsp_vc;
  rand bit                                                  rd_rsp_pool;

  bit [`UPLI_MAX_RD_RSP_CREDIT_INIT_DONE_WIDTH-1:0]         rd_rsp_credit_init_done;
  bit [`UPLI_MAX_RD_RSP_CREDIT_VLD_WIDTH-1:0]               rd_rsp_credit_vld;
  bit [`UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH-1:0]              rd_rsp_credit_pool;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH-1:0]          rd_rsp_credit_port0_vc;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT1_VC_WIDTH-1:0]          rd_rsp_credit_port1_vc;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT2_VC_WIDTH-1:0]          rd_rsp_credit_port2_vc;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT3_VC_WIDTH-1:0]          rd_rsp_credit_port3_vc;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH-1:0]         rd_rsp_credit_port0_num;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT1_NUM_WIDTH-1:0]         rd_rsp_credit_port1_num;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT2_NUM_WIDTH-1:0]         rd_rsp_credit_port2_num;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT3_NUM_WIDTH-1:0]         rd_rsp_credit_port3_num;

  bit                                                       rd_rsp_vld_parity;
  bit                                                       rd_rsp_data_parity;
  bit                                                       rd_rsp_parity;
  bit                                                       rd_rsp_credit_vld_parity;
  bit                                                       rd_rsp_credit_parity;

  // =========================================================
  // Factory Registration
  // =========================================================
  `uvm_object_utils(ualink_upli_transaction)

  // =========================================================
  // Constructor
  // =========================================================
  function new(string name = "ualink_upli_transaction");
    super.new(name);
  endfunction

  // =========================================================
  // Methods
  // =========================================================
  extern virtual function void do_copy(uvm_object rhs);
  extern virtual function string convert2string();
  extern virtual function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern virtual function void do_pack(uvm_packer packer);
  extern virtual function void do_unpack(uvm_packer packer);
  extern virtual function bit is_write_cmd();
  extern virtual function bit is_atomic_cmd();
  extern virtual function bit is_read_cmd();
  extern virtual function bit is_write_vendor_defined_cmd();
  extern virtual function bit is_atomic_vendor_defined_cmd();
  extern virtual function bit is_read_vendor_defined_cmd();
  extern virtual function bit is_credit_update_pkt();
  extern virtual function bit is_req_pool();

endclass : ualink_upli_transaction

`protect
function void ualink_upli_transaction::do_copy(uvm_object rhs);
  ualink_upli_transaction rhs_;
  if (!$cast(rhs_, rhs))
    `uvm_fatal("ualink_upli_transaction", "do_copy cast failed")

  super.do_copy(rhs);

  // -------------------------------
  // Request channel
  // -------------------------------
  req_vld           = rhs_.req_vld;
  req_port_id         = rhs_.req_port_id;
  req_asi             = rhs_.req_asi;
  req_auth_tag        = rhs_.req_auth_tag;
  req_src_phys_acc_id = rhs_.req_src_phys_acc_id;
  req_dst_phys_acc_id = rhs_.req_dst_phys_acc_id;
  req_tag             = rhs_.req_tag;
  req_num_beats       = rhs_.req_num_beats;
  req_addr            = rhs_.req_addr;
  req_cmd             = rhs_.req_cmd;
  req_len             = rhs_.req_len;
  req_attr            = rhs_.req_attr;
  req_meta_data       = rhs_.req_meta_data;
  req_vc              = rhs_.req_vc;
  req_pool            = rhs_.req_pool;

  req_credit_init_done = rhs_.req_credit_init_done;
  req_credit_vld       = rhs_.req_credit_vld;
  req_credit_pool      = rhs_.req_credit_pool;
  req_credit_port0_vc  = rhs_.req_credit_port0_vc;
  req_credit_port1_vc  = rhs_.req_credit_port1_vc;
  req_credit_port2_vc  = rhs_.req_credit_port2_vc;
  req_credit_port3_vc  = rhs_.req_credit_port3_vc;
  req_credit_port0_num = rhs_.req_credit_port0_num;
  req_credit_port1_num = rhs_.req_credit_port1_num;
  req_credit_port2_num = rhs_.req_credit_port2_num;
  req_credit_port3_num = rhs_.req_credit_port3_num;

  req_vld_parity        = rhs_.req_vld_parity;
  req_addr_parity       = rhs_.req_addr_parity;
  req_parity            = rhs_.req_parity;
  req_credit_vld_parity = rhs_.req_credit_vld_parity;
  req_credit_parity     = rhs_.req_credit_parity;

  // -------------------------------
  // Originator data channel
  // -------------------------------
  orig_data_vld      = rhs_.orig_data_vld;
  orig_data_port_id = rhs_.orig_data_port_id;
  orig_data_byte_en = rhs_.orig_data_byte_en;
  orig_data_offset  = rhs_.orig_data_offset;
  orig_data_last    = rhs_.orig_data_last;
  orig_data_error   = rhs_.orig_data_error;
  orig_data_vc      = rhs_.orig_data_vc;
  orig_data_pool    = rhs_.orig_data_pool;

  foreach (orig_data[i])
    orig_data[i] = rhs_.orig_data[i];

  orig_data_credit_init_done = rhs_.orig_data_credit_init_done;
  orig_data_credit_vld       = rhs_.orig_data_credit_vld;
  orig_data_credit_pool      = rhs_.orig_data_credit_pool;
  orig_data_credit_port0_vc  = rhs_.orig_data_credit_port0_vc;
  orig_data_credit_port1_vc  = rhs_.orig_data_credit_port1_vc;
  orig_data_credit_port2_vc  = rhs_.orig_data_credit_port2_vc;
  orig_data_credit_port3_vc  = rhs_.orig_data_credit_port3_vc;
  orig_data_credit_port0_num = rhs_.orig_data_credit_port0_num;
  orig_data_credit_port1_num = rhs_.orig_data_credit_port1_num;
  orig_data_credit_port2_num = rhs_.orig_data_credit_port2_num;
  orig_data_credit_port3_num = rhs_.orig_data_credit_port3_num;

  orig_data_vld_parity        = rhs_.orig_data_vld_parity;
  orig_data_parity            = rhs_.orig_data_parity;
  orig_data_byte_en_parity    = rhs_.orig_data_byte_en_parity;
  orig_data_fields_parity     = rhs_.orig_data_fields_parity;
  orig_data_credit_vld_parity = rhs_.orig_data_credit_vld_parity;
  orig_data_credit_parity     = rhs_.orig_data_credit_parity;

  // -------------------------------
  // Write response channel
  // -------------------------------
  wr_rsp_vld           = rhs_.wr_rsp_vld;
  wr_rsp_port_id       = rhs_.wr_rsp_port_id;
  wr_rsp_auth_tag      = rhs_.wr_rsp_auth_tag;
  wr_rsp_src_phys_acc_id = rhs_.wr_rsp_src_phys_acc_id;
  wr_rsp_dst_phys_acc_id = rhs_.wr_rsp_dst_phys_acc_id;
  wr_rsp_tag           = rhs_.wr_rsp_tag;
  wr_rsp_status        = rhs_.wr_rsp_status;
  wr_rsp_vc            = rhs_.wr_rsp_vc;
  wr_rsp_pool          = rhs_.wr_rsp_pool;

  wr_rsp_credit_init_done = rhs_.wr_rsp_credit_init_done;
  wr_rsp_credit_vld       = rhs_.wr_rsp_credit_vld;
  wr_rsp_credit_pool      = rhs_.wr_rsp_credit_pool;
  wr_rsp_credit_port0_vc  = rhs_.wr_rsp_credit_port0_vc;
  wr_rsp_credit_port1_vc  = rhs_.wr_rsp_credit_port1_vc;
  wr_rsp_credit_port2_vc  = rhs_.wr_rsp_credit_port2_vc;
  wr_rsp_credit_port3_vc  = rhs_.wr_rsp_credit_port3_vc;
  wr_rsp_credit_port0_num = rhs_.wr_rsp_credit_port0_num;
  wr_rsp_credit_port1_num = rhs_.wr_rsp_credit_port1_num;
  wr_rsp_credit_port2_num = rhs_.wr_rsp_credit_port2_num;
  wr_rsp_credit_port3_num = rhs_.wr_rsp_credit_port3_num;

  wr_rsp_vld_parity        = rhs_.wr_rsp_vld_parity;
  wr_rsp_parity            = rhs_.wr_rsp_parity;
  wr_rsp_credit_vld_parity = rhs_.wr_rsp_credit_vld_parity;
  wr_rsp_credit_parity     = rhs_.wr_rsp_credit_parity;

  // -------------------------------
  // Read response + data channel
  // -------------------------------
  rd_rsp_vld      = rhs_.rd_rsp_vld;
  rd_rsp_port_id = rhs_.rd_rsp_port_id;
  rd_rsp_auth_tag = rhs_.rd_rsp_auth_tag;
  rd_rsp_src_phys_acc_id = rhs_.rd_rsp_src_phys_acc_id;
  rd_rsp_dst_phys_acc_id = rhs_.rd_rsp_dst_phys_acc_id;
  rd_rsp_tag      = rhs_.rd_rsp_tag;
  rd_rsp_num_beats = rhs_.rd_rsp_num_beats;
  rd_rsp_status   = rhs_.rd_rsp_status;
  rd_rsp_offset   = rhs_.rd_rsp_offset;
  rd_rsp_last     = rhs_.rd_rsp_last;
  rd_rsp_data_error = rhs_.rd_rsp_data_error;
  rd_rsp_vc       = rhs_.rd_rsp_vc;
  rd_rsp_pool     = rhs_.rd_rsp_pool;

  rd_rsp_data = new[rhs_.rd_rsp_data.size()];
  foreach (rd_rsp_data[i])
    rd_rsp_data[i] = rhs_.rd_rsp_data[i];

  rd_rsp_credit_init_done = rhs_.rd_rsp_credit_init_done;
  rd_rsp_credit_vld       = rhs_.rd_rsp_credit_vld;
  rd_rsp_credit_pool      = rhs_.rd_rsp_credit_pool;
  rd_rsp_credit_port0_vc  = rhs_.rd_rsp_credit_port0_vc;
  rd_rsp_credit_port1_vc  = rhs_.rd_rsp_credit_port1_vc;
  rd_rsp_credit_port2_vc  = rhs_.rd_rsp_credit_port2_vc;
  rd_rsp_credit_port3_vc  = rhs_.rd_rsp_credit_port3_vc;
  rd_rsp_credit_port0_num = rhs_.rd_rsp_credit_port0_num;
  rd_rsp_credit_port1_num = rhs_.rd_rsp_credit_port1_num;
  rd_rsp_credit_port2_num = rhs_.rd_rsp_credit_port2_num;
  rd_rsp_credit_port3_num = rhs_.rd_rsp_credit_port3_num;

  rd_rsp_vld_parity        = rhs_.rd_rsp_vld_parity;
  rd_rsp_data_parity       = rhs_.rd_rsp_data_parity;
  rd_rsp_parity            = rhs_.rd_rsp_parity;
  rd_rsp_credit_vld_parity = rhs_.rd_rsp_credit_vld_parity;
  rd_rsp_credit_parity     = rhs_.rd_rsp_credit_parity;

endfunction

function string ualink_upli_transaction::convert2string();
  string s;

  s = "\n==================== UPLI SEQUENCE ITEM ====================\n";

  // =========================================================
  // REQUEST CHANNEL
  // =========================================================
  if (req_vld) begin
    s = {s, "+==================== REQUEST CHANNEL ====================+\n"};
    s = {s, "| req_port_id             | 0x", $sformatf("%0h", req_port_id), " |\n"};
    s = {s, "| req_asi                 | 0x", $sformatf("%0h", req_asi), " |\n"};
    s = {s, "| req_auth_tag            | 0x", $sformatf("%0h", req_auth_tag), " |\n"};
    s = {s, "| req_src_phys_acc_id     | 0x", $sformatf("%0h", req_src_phys_acc_id), " |\n"};
    s = {s, "| req_dst_phys_acc_id     | 0x", $sformatf("%0h", req_dst_phys_acc_id), " |\n"};
    s = {s, "| req_tag                 | 0x", $sformatf("%0h", req_tag), " |\n"};
    s = {s, "| req_cmd                 | 0x", $sformatf("%0h", req_cmd), " |\n"};
    s = {s, "| req_addr                | 0x", $sformatf("%0h", req_addr), " |\n"};
    s = {s, "| req_len                 | ",  $sformatf("%0d", req_len), " |\n"};
    s = {s, "| req_num_beats           | ",  $sformatf("%0d", req_num_beats), " |\n"};
    s = {s, "| req_attr                | 0x", $sformatf("%0h", req_attr), " |\n"};
    s = {s, "| req_meta_data           | 0x", $sformatf("%0h", req_meta_data), " |\n"};
    s = {s, "| req_vc                  | ",  $sformatf("%0d", req_vc), " |\n"};
    s = {s, "| req_pool                | ",  $sformatf("%0b", req_pool), " |\n"};

    // ---- Credits
    s = {s, "+-------------------- REQ CREDITS --------------------+\n"};
    s = {s, "| credit_init_done        | ", $sformatf("%0b", req_credit_init_done), " |\n"};
    s = {s, "| credit_vld              | ", $sformatf("%0b", req_credit_vld), " |\n"};
    s = {s, "| credit_pool             | ", $sformatf("%0b", req_credit_pool), " |\n"};
    s = {s, "| port0 (vc,num)          | ", $sformatf("(%0d,%0d)", req_credit_port0_vc, req_credit_port0_num), " |\n"};
    s = {s, "| port1 (vc,num)          | ", $sformatf("(%0d,%0d)", req_credit_port1_vc, req_credit_port1_num), " |\n"};
    s = {s, "| port2 (vc,num)          | ", $sformatf("(%0d,%0d)", req_credit_port2_vc, req_credit_port2_num), " |\n"};
    s = {s, "| port3 (vc,num)          | ", $sformatf("(%0d,%0d)", req_credit_port3_vc, req_credit_port3_num), " |\n"};

    // ---- Parity
    s = {s, "+-------------------- REQ PARITY ---------------------+\n"};
    s = {s, "| req_vld_parity          | ", $sformatf("%0b", req_vld_parity), " |\n"};
    s = {s, "| req_addr_parity         | ", $sformatf("%0b", req_addr_parity), " |\n"};
    s = {s, "| req_parity              | ", $sformatf("%0b", req_parity), " |\n"};
    s = {s, "| req_credit_vld_parity   | ", $sformatf("%0b", req_credit_vld_parity), " |\n"};
    s = {s, "| req_credit_parity       | ", $sformatf("%0b", req_credit_parity), " |\n"};
  end

  // =========================================================
  // ORIGINATOR DATA CHANNEL
  // =========================================================
  if (orig_data_vld) begin
    s = {s, "+================ ORIGINATOR DATA CHANNEL ================+\n"};
    s = {s, "| orig_data_port_id       | 0x", $sformatf("%0h", orig_data_port_id), " |\n"};
    s = {s, "| orig_data_offset        | ",  $sformatf("%0d", orig_data_offset), " |\n"};
    s = {s, "| orig_data_last          | ",  $sformatf("%0b", orig_data_last), " |\n"};
    s = {s, "| orig_data_error         | ",  $sformatf("%0b", orig_data_error), " |\n"};
    s = {s, "| orig_data_vc            | ",  $sformatf("%0d", orig_data_vc), " |\n"};
    s = {s, "| orig_data_pool          | ",  $sformatf("%0b", orig_data_pool), " |\n"};
    s = {s, "| orig_data_beats         | ",  $sformatf("%0d", orig_data.size()), " |\n"};

    foreach (orig_data[i])
      s = {s, "| orig_data[", $sformatf("%0d", i),
           "]           | 0x", $sformatf("%0h", orig_data[i]), " |\n"};

    // ---- Credits
    s = {s, "+---------------- ORIG DATA CREDITS ----------------+\n"};
    s = {s, "| credit_init_done        | ", $sformatf("%0b", orig_data_credit_init_done), " |\n"};
    s = {s, "| credit_vld              | ", $sformatf("%0b", orig_data_credit_vld), " |\n"};
    s = {s, "| credit_pool             | ", $sformatf("%0b", orig_data_credit_pool), " |\n"};

    // ---- Parity
    s = {s, "+---------------- ORIG DATA PARITY -----------------+\n"};
    s = {s, "| orig_data_vld_parity    | ", $sformatf("%0b", orig_data_vld_parity), " |\n"};
    s = {s, "| orig_data_parity        | ", $sformatf("%0b", orig_data_parity), " |\n"};
    s = {s, "| orig_data_byte_en_parity| ", $sformatf("%0b", orig_data_byte_en_parity), " |\n"};
    s = {s, "| orig_data_fields_parity | ", $sformatf("%0b", orig_data_fields_parity), " |\n"};
    s = {s, "| orig_data_credit_vld_parity | ", $sformatf("%0b", orig_data_credit_vld_parity), " |\n"};
    s = {s, "| orig_data_credit_parity     | ", $sformatf("%0b", orig_data_credit_parity), " |\n"};
  end

  // =========================================================
  // WRITE RESPONSE CHANNEL
  // =========================================================
  if (wr_rsp_vld) begin
    s = {s, "+================ WRITE RESPONSE CHANNEL ================+\n"};
    s = {s, "| wr_rsp_port_id          | 0x", $sformatf("%0h", wr_rsp_port_id), " |\n"};
    s = {s, "| wr_rsp_auth_tag         | 0x", $sformatf("%0h", wr_rsp_auth_tag), " |\n"};
    s = {s, "| wr_rsp_tag              | 0x", $sformatf("%0h", wr_rsp_tag), " |\n"};
    s = {s, "| wr_rsp_status           | 0x", $sformatf("%0h", wr_rsp_status), " |\n"};
    s = {s, "| wr_rsp_vc               | ",  $sformatf("%0d", wr_rsp_vc), " |\n"};
    s = {s, "| wr_rsp_pool             | ",  $sformatf("%0b", wr_rsp_pool), " |\n"};

    // ---- Credits
    s = {s, "+---------------- WR RSP CREDITS ----------------+\n"};
    s = {s, "| credit_init_done        | ", $sformatf("%0b", wr_rsp_credit_init_done), " |\n"};
    s = {s, "| credit_vld              | ", $sformatf("%0b", wr_rsp_credit_vld), " |\n"};
    s = {s, "| credit_pool             | ", $sformatf("%0b", wr_rsp_credit_pool), " |\n"};

    // ---- Parity
    s = {s, "+---------------- WR RSP PARITY -----------------+\n"};
    s = {s, "| wr_rsp_vld_parity       | ", $sformatf("%0b", wr_rsp_vld_parity), " |\n"};
    s = {s, "| wr_rsp_parity           | ", $sformatf("%0b", wr_rsp_parity), " |\n"};
    s = {s, "| wr_rsp_credit_vld_parity| ", $sformatf("%0b", wr_rsp_credit_vld_parity), " |\n"};
    s = {s, "| wr_rsp_credit_parity    | ", $sformatf("%0b", wr_rsp_credit_parity), " |\n"};
  end

  // =========================================================
  // READ RESPONSE + DATA CHANNEL
  // =========================================================
  if (rd_rsp_vld) begin
    s = {s, "+================ READ RESPONSE CHANNEL =================+\n"};
    s = {s, "| rd_rsp_port_id          | 0x", $sformatf("%0h", rd_rsp_port_id), " |\n"};
    s = {s, "| rd_rsp_auth_tag         | 0x", $sformatf("%0h", rd_rsp_auth_tag), " |\n"};
    s = {s, "| rd_rsp_tag              | 0x", $sformatf("%0h", rd_rsp_tag), " |\n"};
    s = {s, "| rd_rsp_status           | 0x", $sformatf("%0h", rd_rsp_status), " |\n"};
    s = {s, "| rd_rsp_num_beats        | ",  $sformatf("%0d", rd_rsp_num_beats), " |\n"};
    s = {s, "| rd_rsp_offset           | ",  $sformatf("%0d", rd_rsp_offset), " |\n"};
    s = {s, "| rd_rsp_last             | ",  $sformatf("%0b", rd_rsp_last), " |\n"};
    s = {s, "| rd_rsp_data_error       | ",  $sformatf("%0b", rd_rsp_data_error), " |\n"};
    s = {s, "| rd_rsp_vc               | ",  $sformatf("%0d", rd_rsp_vc), " |\n"};
    s = {s, "| rd_rsp_pool             | ",  $sformatf("%0b", rd_rsp_pool), " |\n"};
    s = {s, "| rd_rsp_data_beats       | ",  $sformatf("%0d", rd_rsp_data.size()), " |\n"};

    foreach (rd_rsp_data[i])
      s = {s, "| rd_rsp_data[", $sformatf("%0d", i),
           "]         | 0x", $sformatf("%0h", rd_rsp_data[i]), " |\n"};

    // ---- Credits
    s = {s, "+---------------- RD RSP CREDITS ----------------+\n"};
    s = {s, "| credit_init_done        | ", $sformatf("%0b", rd_rsp_credit_init_done), " |\n"};
    s = {s, "| credit_vld              | ", $sformatf("%0b", rd_rsp_credit_vld), " |\n"};
    s = {s, "| credit_pool             | ", $sformatf("%0b", rd_rsp_credit_pool), " |\n"};

    // ---- Parity
    s = {s, "+---------------- RD RSP PARITY -----------------+\n"};
    s = {s, "| rd_rsp_vld_parity       | ", $sformatf("%0b", rd_rsp_vld_parity), " |\n"};
    s = {s, "| rd_rsp_data_parity      | ", $sformatf("%0b", rd_rsp_data_parity), " |\n"};
    s = {s, "| rd_rsp_parity           | ", $sformatf("%0b", rd_rsp_parity), " |\n"};
    s = {s, "| rd_rsp_credit_vld_parity| ", $sformatf("%0b", rd_rsp_credit_vld_parity), " |\n"};
    s = {s, "| rd_rsp_credit_parity    | ", $sformatf("%0b", rd_rsp_credit_parity), " |\n"};
  end

  s = {s, "===========================================================\n"};
  return s;
endfunction

// =========================================================
// Compare (data beat aware)
// =========================================================
function bit ualink_upli_transaction::do_compare(uvm_object rhs,
                                uvm_comparer comparer);
  ualink_upli_transaction rhs_;
  if (!$cast(rhs_, rhs_))
    return 0;

  if (!super.do_compare(rhs, comparer))
    return 0;

  if (orig_data.size() != rhs_.orig_data.size()) return 0;
  foreach (orig_data[i])
    if (orig_data[i] != rhs_.orig_data[i]) return 0;

  if (rd_rsp_data.size() != rhs_.rd_rsp_data.size()) return 0;
  foreach (rd_rsp_data[i])
    if (rd_rsp_data[i] != rhs_.rd_rsp_data[i]) return 0;

  return 1;
endfunction

// =========================================================
// Pack / Unpack
// =========================================================
function void ualink_upli_transaction::do_pack(uvm_packer packer);
  super.do_pack(packer);

  packer.pack_field_int(orig_data.size(), 3);
  foreach (orig_data[i])
    packer.pack_field_int(orig_data[i], `UPLI_MAX_ORIG_DATA_WIDTH);

  packer.pack_field_int(rd_rsp_data.size(), 3);
  foreach (rd_rsp_data[i])
    packer.pack_field_int(rd_rsp_data[i], `UPLI_MAX_RD_RSP_DATA_WIDTH);
endfunction

// =========================================================
// Pack / Unpack
// =========================================================
function void ualink_upli_transaction::do_unpack(uvm_packer packer);
  int beats;
  super.do_unpack(packer);

  beats = packer.unpack_field_int(3);
  foreach (orig_data[i])
    orig_data[i] = packer.unpack_field_int(`UPLI_MAX_ORIG_DATA_WIDTH);

  beats = packer.unpack_field_int(3);
  rd_rsp_data = new[beats];
  foreach (rd_rsp_data[i])
    rd_rsp_data[i] = packer.unpack_field_int(`UPLI_MAX_RD_RSP_DATA_WIDTH);
endfunction: do_unpack

// =========================================================
// is_write_cmd
// =========================================================
function bit ualink_upli_transaction::is_write_cmd();

  if(this.req_cmd inside {UPLI_CMD_WRITE, UPLI_CMD_WRITE_FULL `ifdef UPLI_VENDOR_WRITE_CMDS , `UPLI_VENDOR_WRITE_CMDS `endif}) begin
    return 1;
  end
  else begin
    return 0;
  end

endfunction: is_write_cmd

// =========================================================
// is_atomic_cmd
// =========================================================
function bit ualink_upli_transaction::is_atomic_cmd();

  if(this.req_cmd inside {UPLI_CMD_ATOMIC_RETURN, UPLI_CMD_ATOMIC_NO_RETURN `ifdef UPLI_VENDOR_ATOMIC_CMDS , `UPLI_VENDOR_ATOMIC_CMDS `endif}) begin
    return 1;
  end
  else begin
    return 0;
  end

endfunction: is_atomic_cmd

// =========================================================
// is_read_cmd
// =========================================================
function bit ualink_upli_transaction::is_read_cmd();

  if(this.req_cmd inside {UPLI_CMD_READ `ifdef UPLI_VENDOR_READ_CMDS , `UPLI_VENDOR_READ_CMDS `endif}) begin
    return 1;
  end
  else begin
    return 0;
  end

endfunction: is_read_cmd

// =========================================================
// is_write_vendor_defined_cmd
// =========================================================
function bit ualink_upli_transaction::is_write_vendor_defined_cmd();

  `ifdef UPLI_VENDOR_WRITE_CMDS
  if(this.req_cmd inside {`UPLI_VENDOR_WRITE_CMDS}) begin
    return 1;
  end
  else begin
    return 0;
  end
  `else
  return 0;
  `endif

endfunction: is_write_vendor_defined_cmd

// =========================================================
// is_atomic_vendor_defined_cmd
// =========================================================
function bit ualink_upli_transaction::is_atomic_vendor_defined_cmd();

  `ifdef UPLI_VENDOR_ATOMIC_CMDS
  if(this.req_cmd inside {`UPLI_VENDOR_ATOMIC_CMDS}) begin
    return 1;
  end
  else begin
    return 0;
  end
  `else
  return 0;
  `endif

endfunction: is_atomic_vendor_defined_cmd

// =========================================================
// is_read_vendor_defined_cmd
// =========================================================
function bit ualink_upli_transaction::is_read_vendor_defined_cmd();

  `ifdef UPLI_VENDOR_READ_CMDS
  if(this.req_cmd inside {`UPLI_VENDOR_READ_CMDS}) begin
    return 1;
  end
  else begin
    return 0;
  end
  `else
  return 0;
  `endif

endfunction: is_read_vendor_defined_cmd

// =========================================================
// is_credit_update_pkt
// =========================================================
function bit ualink_upli_transaction::is_credit_update_pkt();

  return req_credit_vld || orig_data_credit_vld || wr_rsp_credit_vld || rd_rsp_credit_vld ||
         req_credit_init_done || orig_data_credit_init_done || wr_rsp_credit_init_done ||
         rd_rsp_credit_init_done;

endfunction: is_credit_update_pkt

// =========================================================
// is_req_pool
// =========================================================
function bit ualink_upli_transaction::is_req_pool();

  return req_pool && req_vld;

endfunction: is_req_pool



`endprotect
`endif // UALINK_UPLI_TRANSACTION
