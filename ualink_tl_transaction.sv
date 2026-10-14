`ifndef UALINK_TL_TRANSACTION
`define UALINK_TL_TRANSACTION

//------------------------------------------------------------------------------
// TL HALF-FLIT TYPE ENUM
//------------------------------------------------------------------------------
typedef enum bit [2:0] {
  tl_control_flit,     // Control half-flit (uncompressed_req/rsp)
  tl_data_flit,        // (reserved for future) data half-flit
  tl_msg_flit,         // Message half-flit (32B)
  tl_nop_fc_flit       // NOP / Flow Control
} tl_half_flit_type_e;

//------------------------------------------------------------------------------
// TL REQUEST CMD ENUM
//------------------------------------------------------------------------------
typedef enum bit [5:0] {
  TL_RD           = 'h03,
  TL_WR           = 'h28,
  TL_WR_FULL      = 'h29,
  TL_UPLI_WR_MSG  = 'h2A,
  TL_ATOMIC_R     = 'h30,
  TL_ATOMIC_NR    = 'h32
} tl_upli_req_cmd_e;

//------------------------------------------------------------------------------
// TL WRITE RESPONSE STATUS ENUM
//------------------------------------------------------------------------------
typedef enum logic [3:0] {
  WR_RSP_OKAY                 = 4'b0000,
  WR_RSP_TARGET_ABORT         = 4'b0010,
  WR_RSP_DECODE_ERROR         = 4'b0011,
  WR_RSP_PROTECTION_VIOLATION = 4'b0110,
  WR_RSP_COMPLETION_TIMEOUT   = 4'b1000,
  WR_RSP_ISOLATE              = 4'b1111
} tl_wr_rsp_status_e;

//------------------------------------------------------------------------------
// TL READ RESPONSE STATUS ENUM
//------------------------------------------------------------------------------
typedef enum logic [3:0] {
  RD_RSP_OKAY                 = 4'b0000,
  RD_RSP_TARGET_ABORT         = 4'b0010,
  RD_RSP_DECODE_ERROR         = 4'b0011,
  RD_RSP_PROTECTION_VIOLATION = 4'b0110,
  RD_RSP_COMPLETION_TIMEOUT   = 4'b1000
} tl_rd_rsp_status_e;

//------------------------------------------------------------------------------
// TL REQUEST/RESPONSE TYPE ENUM
//------------------------------------------------------------------------------
typedef enum {
  uncompressed_req,
  uncompressed_rsp,
  compressed_req,
  compressed_rsp
} tl_req_resp_type_e;

//------------------------------------------------------------------------------
// MESSAGE HALF-FLIT (32B)
//------------------------------------------------------------------------------
typedef struct packed {
  logic [7:0]    msg_type;
  logic [247:0]  msg_payload;
} tl_msg_half_flit_t;

//------------------------------------------------------------------------------
// UNCOMPRESSED REQ STRUCT (32B)
//------------------------------------------------------------------------------
typedef struct packed {
  logic [3:0]      ftype;
  logic [5:0]      cmd;
  logic [1:0]      vchan;
  logic [1:0]      asi;
  logic [10:0]     tag;
  logic            pool;
  logic [7:0]      attr;
  logic [5:0]      len;
  logic [7:0]      metadata;
  logic [54:0]     addr;
  logic [9:0]      srcaccid;
  logic [9:0]      dstaccid;
  logic            cload;
  logic [1:0]      cway;
  logic [1:0]      numbeats;
} uncompressed_req_e;

//------------------------------------------------------------------------------
// UNCOMPRESSED RSP STRUCT (32B)
//------------------------------------------------------------------------------
typedef struct packed {
  logic [3:0]      ftype;
  logic [1:0]      vchan;
  logic [10:0]     tag;
  logic            pool;
  logic [1:0]      len;
  logic [1:0]      offset;
  logic [3:0]      status;
  logic            rd_wr;
  logic            last;
  logic [9:0]      srcaccid;
  logic [9:0]      dstaccid;
  logic [15:0]     spare;
} uncompressed_rsp_e;

//------------------------------------------------------------------------------
// COMPRESSED REQ STRUCT
//------------------------------------------------------------------------------
typedef struct packed {
  logic [3:0]      ftype;
  logic [2:0]      cmd;
  logic [1:0]      vchan;
  logic [1:0]      asi;
  logic [10:0]     tag;
  logic            pool;
  logic [1:0]      len;
  logic [2:0]      metadata;
  logic [13:0]     addr;
  logic [9:0]      srcaccid;
  logic [9:0]      dstaccid;
  logic [1:0]      cway;
} compressed_req_e;

//------------------------------------------------------------------------------
// COMPRESSED RSP STRUCT
//------------------------------------------------------------------------------
typedef struct packed {
  logic [3:0]      ftype;
  logic [1:0]      vchan;
  logic [10:0]     tag;
  logic            pool;
  logic [9:0]      dstaccid;
  logic [1:0]      offset;
  logic            last;
  logic            spare;
} compressed_rsp_e;

//------------------------------------------------------------------------------
// TL TRANSACTION CLASS (ONE 32B CONTROL / MSG HALF-FLIT)
//------------------------------------------------------------------------------
class ualink_tl_transaction extends uvm_sequence_item;

  logic [511:0] data_64B[];

  tl_half_flit_type_e  tl_half_flit_type;
  tl_upli_req_cmd_e    tl_req_cmd;
  tl_wr_rsp_status_e   tl_wr_rsp_status;
  tl_rd_rsp_status_e   tl_rd_rsp_status;
  tl_req_resp_type_e   tl_req_resp_type;

  uncompressed_req_e     uncomp_req;
  uncompressed_rsp_e     uncomp_rsp;
  compressed_req_e       comp_req;
  compressed_rsp_e       comp_rsp;

  tl_msg_half_flit_t   msg_flit;

  `uvm_object_utils_begin(ualink_tl_transaction)
    `uvm_field_enum (tl_half_flit_type_e, tl_half_flit_type, UVM_ALL_ON)
    `uvm_field_enum (tl_upli_req_cmd_e,   tl_req_cmd,        UVM_ALL_ON)
    `uvm_field_enum (tl_wr_rsp_status_e,  tl_wr_rsp_status,  UVM_ALL_ON)
    `uvm_field_enum (tl_rd_rsp_status_e,  tl_rd_rsp_status,  UVM_ALL_ON)
    `uvm_field_enum (tl_req_resp_type_e,  tl_req_resp_type,  UVM_ALL_ON)

//    `uvm_field_struct(uncomp_req, UVM_ALL_ON)
//    `uvm_field_struct(uncomp_rsp, UVM_ALL_ON)
//    `uvm_field_struct(comp_req,   UVM_ALL_ON)
//    `uvm_field_struct(comp_rsp,   UVM_ALL_ON)
//    `uvm_field_struct(msg_flit,   UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="ualink_tl_transaction");
    super.new(name);
  endfunction

//  function void do_print(uvm_printer printer);
//    super.do_print(printer);
//
//    printer.print_enum("tl_half_flit_type", tl_half_flit_type.name());
//
//    case (tl_half_flit_type)
//
//      tl_control_flit: begin
//        printer.print_enum("tl_req_resp_type", tl_req_resp_type.name());
//        case (tl_req_resp_type)
//          uncompressed_req: printer.print_struct("uncompressed_req", uncomp_req);
//          uncompressed_rsp: printer.print_struct("uncompressed_rsp", uncomp_rsp);
//          compressed_req:   printer.print_struct("compressed_req",   comp_req);
//          compressed_rsp:   printer.print_struct("compressed_rsp",   comp_rsp);
//        endcase
//      end
//
//      tl_msg_flit:
//        printer.print_struct("msg_flit", msg_flit);
//
//      tl_nop_fc_flit:
//        printer.print_string("nop_fc", "NOP / Flow Control");
//
//      default: ; // tl_data_flit reserved / unused here
//
//    endcase
//  endfunction

endclass

`endif


