
`ifndef UALINK_UPLI_COMPLETER_ACTIVE_COMMON_SV
`define UALINK_UPLI_COMPLETER_ACTIVE_COMMON_SV

typedef class ualink_upli_completer_driver;

class ualink_upli_completer_active_common #(
    type DRIVER_MP = virtual ualink_upli_completer_interface.upli_comp_drv_mp,
    type MONITOR_MP = virtual ualink_upli_completer_interface.upli_comp_mon_mp)
    extends ualink_upli_completer_common #(MONITOR_MP);

  // Driver modport for completer.
  protected DRIVER_MP driver_mp;

  // ualink_upli_compnator_driver driver handle.
  ualink_upli_completer_driver driver;

  /**
   * CONSTRCTUR: Create a new ualink_upli_completer_active_common class instance.
   *
   * @param cfg ualink_upli_config config class handle
   * @param reporter uvm_report_object class handle
   */
  extern function new (ualink_upli_config cfg, uvm_report_object reporter);

  /**
   * start to start all the process
   */
  extern virtual task start();

  /**
   * async_init_signals to reset all the signals asyncronusly when reset asserted.
   */
  extern virtual task async_init_signals();

  /**
   * initialize_signals to initalize signals to there default values syncronus to UPLI_CLK.
   */
  extern virtual task initialize_signals();

  /**
   * update_on_reset to reset variables of this class when reset asserted.
   */
  extern virtual task update_on_reset();

  /**
   * drive_xact to Get and drive ualink_upli_transaction packets.
   *
   * @param xact handle for ualink_upli_transaction.
   */
  extern virtual function drive_xact(ualink_upli_transaction xact);

  /**
   * drive_req_channel to drive write response channel signals
   */
  extern virtual task drive_wr_rsp_channel();

  /**
   * drive_comp_data_channel to drive read response channel signals
   */
  extern virtual task drive_rd_rsp_channel();

  /**
   * drive_wr_rsp_credits to drive request channel credit signals
   */
  extern virtual task drive_req_credits();

  /**
   * drive_rd_rsp_credits to drive orignator data channel credit signals
   */
  extern virtual task drive_orig_data_credits();

  /**
   * set_interface to set all the virtual interfaces.
   */
  extern virtual function set_interface(virtual ualink_upli_completer_interface comp_vif);

endclass: ualink_upli_completer_active_common

// ==================================================================
function ualink_upli_completer_active_common::new (ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction : new

// ==================================================================
function ualink_upli_completer_active_common::set_interface(virtual ualink_upli_completer_interface comp_vif);
  super.set_interface(comp_vif);
  driver_mp = comp_vif.upli_comp_drv_mp;
endfunction: set_interface

// ==================================================================
task ualink_upli_completer_active_common::start();

  super.start();

  fork

    drive_wr_rsp_channel();
    drive_rd_rsp_channel();
    drive_req_credits();
    drive_orig_data_credits();
  join_none

  wait fork;
endtask: start

// ==================================================================
task ualink_upli_completer_active_common::async_init_signals();

endtask: async_init_signals

// ==================================================================
task ualink_upli_completer_active_common::initialize_signals();

endtask: initialize_signals

// ==================================================================
task ualink_upli_completer_active_common::update_on_reset();

endtask: update_on_reset

// ==================================================================
function ualink_upli_completer_active_common::drive_xact(ualink_upli_transaction xact);

endfunction: drive_xact

// ==================================================================
task ualink_upli_completer_active_common::drive_wr_rsp_channel();

endtask: drive_wr_rsp_channel

// ==================================================================
task ualink_upli_completer_active_common::drive_rd_rsp_channel();

endtask: drive_rd_rsp_channel

// ==================================================================
task ualink_upli_completer_active_common::drive_req_credits();

endtask: drive_req_credits

// ==================================================================
task ualink_upli_completer_active_common::drive_orig_data_credits();

endtask: drive_orig_data_credits

`endif // UALINK_UPLI_COMPLETER_ACTIVE_COMMON_SV
