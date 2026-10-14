
`ifndef UALINK_UPLI_ENV_PKG_SV
`define UALINK_UPLI_ENV_PKG_SV

`include "ualink_upli_pkg.sv"
`include "ualink_tl_pkg.sv" 

package ualink_upli_env_pkg;

  import ualink_upli_pkg::*;
  import ualink_tl_pkg::*;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  `include "ualink_upli_cust_config.sv"
  `include "ualink_upli_basic_env.sv"

  `include "ualink_upli_base_test.sv"

endpackage: ualink_upli_env_pkg

`endif // UALINK_UPLI_PKG_SV
