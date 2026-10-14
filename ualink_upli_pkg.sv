
`include "ualink_upli_defines.sv"
`include "ualink_upli_interface.incl"
`include "ualink_upli_enum_pkg.sv"

package ualink_upli_pkg;

  `include "uvm_macros.svh"
  import uvm_pkg::*;

  import ualink_upli_enum_pkg::*;

  `include "ualink_upli_src.incl"
  `include "ualink_upli_orignator_agent.incl"
  `include "ualink_upli_completer_agent.incl"
  `include "ualink_upli_env.incl"

endpackage: ualink_upli_pkg
