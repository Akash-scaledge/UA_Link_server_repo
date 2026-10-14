
//-----------------------------------------------------------------------------
// 1. Defines
//-----------------------------------------------------------------------------
`define UPLI_ORIGNATOR_INTF_0// enable get_orignator_if(0) since `UPLI_NUM_OF_ORIGNATOR_IF=1
`define UPLI_COMPLETER_INTF_0  // enable get_completer_if(0) since `UPLI_NUM_OF_COMPLETER_IF=1

`define UPLI_ORIGNATOR_INTF_1// enable get_orignator_if(1) since `UPLI_NUM_OF_ORIGNATOR_IF=2
`define UPLI_COMPLETER_INTF_1// enable get_completer_if(1) since `UPLI_NUM_OF_COMPLETER_IF=2

`include "ualink_upli_defines.sv"

//-----------------------------------------------------------------------------
// 2. Interfaces
//-----------------------------------------------------------------------------
`include "ualink_upli_orignator_interface.svi"
`include "ualink_upli_completer_interface.svi"
`include "ualink_upli_interface.svi"

//-----------------------------------------------------------------------------
// 3. Enums 
//-----------------------------------------------------------------------------
`include "ualink_upli_enum_pkg.sv"
import ualink_upli_enum_pkg::*;

//-----------------------------------------------------------------------------
// 4. UPLI: config, transactions, common
//-----------------------------------------------------------------------------
`include "ualink_upli_config.sv"
`include "ualink_upli_env_config.sv"
`include "ualink_upli_transaction.svh"
`include "ualink_upli_orignator_transaction.sv"
`include "ualink_upli_completer_transaction.sv"
`include "ualink_upli_common.sv"

//-----------------------------------------------------------------------------
// 5. UPLI originator agent
//-----------------------------------------------------------------------------
`include "ualink_upli_orignator_common.sv"
`include "ualink_upli_orignator_active_common.sv"
`include "ualink_upli_orignator_monitor_common.sv"
`include "ualink_upli_orignator_driver.sv"
`include "ualink_upli_orignator_monitor.sv"
`include "ualink_upli_orignator_sequencer.sv"
`include "ualink_upli_orignator_agent.sv"

//-----------------------------------------------------------------------------
// 6. UPLI completer agent
//-----------------------------------------------------------------------------
`include "ualink_upli_completer_common.sv"
`include "ualink_upli_completer_active_common.sv"
`include "ualink_upli_completer_monitor_common.sv"
`include "ualink_upli_completer_driver.sv"
`include "ualink_upli_completer_monitor.sv"
`include "ualink_upli_completer_sequencer.sv"
`include "ualink_upli_completer_agent.sv"

//-----------------------------------------------------------------------------
// 7. UPLI env
//-----------------------------------------------------------------------------
`include "ualink_upli_env.sv"

//-----------------------------------------------------------------------------
// 8. Transaction Layer
//-----------------------------------------------------------------------------
`include "ualink_tl_transaction.sv"
`include "ualink_tl_tx_flit_transactor.sv"
`include "ualink_tl_env.sv"

//-----------------------------------------------------------------------------
// 9. Top env + tests
//-----------------------------------------------------------------------------
`include "ualink_upli_cust_config.sv"
`include "ualink_upli_basic_env.sv"
`include "ualink_upli_base_test.sv"

//-----------------------------------------------------------------------------
// 10. HDL wrapper (Originator <-> Completer)
//-----------------------------------------------------------------------------
`include "ualink_upli_hdl_wrapper.sv"

//-----------------------------------------------------------------------------
// 10. TOP
//-----------------------------------------------------------------------------
`include "ualink_upli_top.sv"
