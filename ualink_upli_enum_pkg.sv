
`ifndef UALINK_UPLI_ENUM_PKG_SV
`define UALINK_UPLI_ENUM_PKG_SV

package ualink_upli_enum_pkg;

// Request command types.
typedef enum logic [`UPLI_MAX_REQ_CMD_WIDTH-1:0] {

  // ---------------- Standard Commands ----------------
  UPLI_CMD_READ              = 6'h03,
  UPLI_CMD_WRITE             = 6'h28,
  UPLI_CMD_WRITE_FULL        = 6'h29,
  UPLI_CMD_WRITE_MESSAGE     = 6'h2A,
  UPLI_CMD_ATOMIC_RETURN     = 6'h30,
  UPLI_CMD_ATOMIC_NO_RETURN  = 6'h32

`ifdef UPLI_VENDOR_READ_CMDS
  ,
  `UPLI_VENDOR_READ_CMDS
`endif

`ifdef UPLI_VENDOR_WRITE_CMDS
  ,
  `UPLI_VENDOR_WRITE_CMDS
`endif

`ifdef UPLI_VENDOR_ATOMIC_CMDS
  ,
  `UPLI_VENDOR_ATOMIC_CMDS
`endif

} upli_reqcmd_e;

// Bifurgation Mode
typedef enum logic [1:0] {

  UPLI_BIF_X4_1 = 2'b00,
  UPLI_BIF_X2_2 = 2'b01,
  UPLI_BIF_X1_4 = 2'b10

} upli_bif_e;

endpackage: ualink_upli_enum_pkg

`endif // UALINK_UPLI_ENUM_PKG_SV
