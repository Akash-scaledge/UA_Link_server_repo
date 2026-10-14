`ifndef UALINK_UPLI_COMPLETER_MONITOR_COMMON_SV
`define UALINK_UPLI_COMPLETER_MONITOR_COMMON_SV

class ualink_upli_completer_monitor_common #(
  type MONITOR_MP = virtual ualink_upli_completer_interface.upli_comp_mon_mp)
  extends ualink_upli_completer_common#(MONITOR_MP);

  /**
   * CONSTRCTUR: Create a new ualink_upli_completer_active_common class instance.
   *
   * @param cfg ualink_upli_config config class handle
   * @param reporter uvm_report_object class handle
   */
  extern function new (ualink_upli_config cfg, uvm_report_object reporter);

  /**
   * start to start all the process.
   */
  extern virtual task start();

  /**
   * update_on_reset to reset variables of this class when reset asserted.
   */
  extern virtual task update_on_reset();

  /**
   * sample_req_channel_signals to sample write response channel signals.
   */
  extern virtual task sample_wr_rsp_channel_signals();

  /**
   * sample_comp_data_channel_signals to sample read response channel signals.
   */
  extern virtual task sample_rd_rsp_channel_signals();

  /**
   * sample_wr_rsp_credit_signals to sample request channel credit signals.
   */
  extern virtual task sample_req_credit_signals();

  /**
   * sample_comp_data_channel_signals to sample orignator data channel credit signals.
   */
  extern virtual task sample_orig_data_credit_signals();

endclass: ualink_upli_completer_monitor_common

// ==================================================================
function ualink_upli_completer_monitor_common::new(ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction: new

// ==================================================================
task ualink_upli_completer_monitor_common::start();

  super.start();

  fork
    sample_wr_rsp_channel_signals();
    sample_rd_rsp_channel_signals();
    sample_req_credit_signals();
    sample_orig_data_credit_signals();
  join_none

  wait fork;
endtask: start

// ==================================================================
task ualink_upli_completer_monitor_common::update_on_reset();
endtask: update_on_reset

// ==================================================================
task ualink_upli_completer_monitor_common::sample_wr_rsp_channel_signals();
endtask: sample_wr_rsp_channel_signals

// ==================================================================
task ualink_upli_completer_monitor_common::sample_rd_rsp_channel_signals();
endtask: sample_rd_rsp_channel_signals

// ==================================================================
task ualink_upli_completer_monitor_common::sample_req_credit_signals();
endtask: sample_req_credit_signals

// ==================================================================
task ualink_upli_completer_monitor_common::sample_orig_data_credit_signals();
endtask: sample_orig_data_credit_signals

`endif // UALINK_UPLI_COMPLETER_MONITOR_COMMON_SV
