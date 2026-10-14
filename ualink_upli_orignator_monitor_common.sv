`ifndef UALINK_UPLI_ORIGNATOR_MONITOR_COMMON_SV
`define UALINK_UPLI_ORIGNATOR_MONITOR_COMMON_SV

`define ORIG_MON_CB monitor_mp.upli_orignator_mon_cb

class ualink_upli_orignator_monitor_common #(
  type MONITOR_MP = virtual ualink_upli_orignator_interface.upli_orig_mon_mp)
  extends ualink_upli_orignator_common#(MONITOR_MP);

  /**
   * CONSTRCTUR: Create a new ualink_upli_orignator_active_common class instance.
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
   * sample_req_channel_signals to sample orignator data channel signals.
   */
  extern virtual task sample_req_channel_signals();

  /**
   * sample_orig_data_channel_signals to sample orignator data channel signals.
   */
  extern virtual task sample_orig_data_channel_signals();

  /**
   * sample_wr_rsp_credit_signals to sample write response channel credit signals.
   */
  extern virtual task sample_wr_rsp_credit_signals();

  /**
   * sample_orig_data_channel_signals to sample read response and data channel credit signals.
   */
  extern virtual task sample_rd_rsp_credit_signals();

endclass: ualink_upli_orignator_monitor_common

// ==================================================================
function ualink_upli_orignator_monitor_common::new(ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction: new

// ==================================================================
task ualink_upli_orignator_monitor_common::start();

  super.start();

  fork
    sample_req_channel_signals();
    sample_orig_data_channel_signals();
    sample_wr_rsp_credit_signals();
    sample_rd_rsp_credit_signals();
  join_none

  wait fork;
endtask: start

// ==================================================================
task ualink_upli_orignator_monitor_common::update_on_reset();

  super.update_on_reset();

endtask: update_on_reset

// ==================================================================
task ualink_upli_orignator_monitor_common::sample_req_channel_signals();
  ualink_upli_orignator_transaction req_channel_h;

  forever begin
    @(`ORIG_MON_CB);
    if (`ORIG_MON_CB.req_valid) begin
      req_channel_h = ualink_upli_orignator_transaction::type_id::create("req_channel_h");
      req_channel_h.req_vld             = `ORIG_MON_CB.req_valid;
      req_channel_h.req_port_id         = `ORIG_MON_CB.req_port_id;
      req_channel_h.req_asi             = `ORIG_MON_CB.req_asi;
      req_channel_h.req_auth_tag        = `ORIG_MON_CB.req_auth_tag;
      req_channel_h.req_src_phys_acc_id = `ORIG_MON_CB.req_src_phys_acc_id;
      req_channel_h.req_dst_phys_acc_id = `ORIG_MON_CB.req_dst_phys_acc_id;
      req_channel_h.req_tag             = `ORIG_MON_CB.req_tag;
      req_channel_h.req_num_beats       = `ORIG_MON_CB.req_num_beats;
      req_channel_h.req_addr            = `ORIG_MON_CB.req_addr;
      req_channel_h.req_cmd             = `ORIG_MON_CB.req_cmd;
      req_channel_h.req_len             = `ORIG_MON_CB.req_len;
      req_channel_h.req_attr            = `ORIG_MON_CB.req_attr;
      req_channel_h.req_meta_data       = `ORIG_MON_CB.req_meta_data;
      req_channel_h.req_vc              = `ORIG_MON_CB.req_vc;
      req_channel_h.req_pool            = `ORIG_MON_CB.req_pool;
      req_channel_h.req_vld_parity      = `ORIG_MON_CB.req_vld_parity;
      req_channel_h.req_addr_parity     = `ORIG_MON_CB.req_addr_parity;
      req_channel_h.req_parity          = `ORIG_MON_CB.req_parity;
    end
  end
endtask: sample_req_channel_signals

// ==================================================================
task ualink_upli_orignator_monitor_common::sample_orig_data_channel_signals();

  ualink_upli_orignator_transaction      orig_data_h;

  forever begin
    @(`ORIG_MON_CB);

    if (`ORIG_MON_CB.orig_data_vld) begin
      orig_data_h = ualink_upli_orignator_transaction::type_id::create("orig_data_h");

      orig_data_h.orig_data.push_back(`ORIG_MON_CB.orig_data);
      orig_data_h.orig_data_byte_en.push_back(`ORIG_MON_CB.orig_data_byte_en);
      orig_data_h.orig_data_vld            = `ORIG_MON_CB.orig_data_vld;
      orig_data_h.orig_data_port_id        = `ORIG_MON_CB.orig_data_port_id;
      orig_data_h.orig_data_offset         = `ORIG_MON_CB.orig_data_offset;
      orig_data_h.orig_data_last           = `ORIG_MON_CB.orig_data_last;
      orig_data_h.orig_data_error          = `ORIG_MON_CB.orig_data_error;
      orig_data_h.orig_data_vc             = `ORIG_MON_CB.orig_data_vc;
      orig_data_h.orig_data_pool           = `ORIG_MON_CB.orig_data_pool;
      orig_data_h.orig_data_vld_parity     = `ORIG_MON_CB.orig_data_vld_parity;
      orig_data_h.orig_data_parity         = `ORIG_MON_CB.orig_data_parity;
      orig_data_h.orig_data_byte_en_parity = `ORIG_MON_CB.orig_data_byte_en_parity;
      orig_data_h.orig_data_fields_parity  = `ORIG_MON_CB.orig_data_fields_parity;

      orignator_monitor.orig_mon_ap.write(orig_data_h);
    end
  end

endtask: sample_orig_data_channel_signals

// ==================================================================
task ualink_upli_orignator_monitor_common::sample_wr_rsp_credit_signals();

  ualink_upli_orignator_transaction wr_rsp_credit_h;

  forever begin
    @(`ORIG_MON_CB);

    if (`ORIG_MON_CB.wr_rsp_credit_vld > 0) begin

      wr_rsp_credit_h = ualink_upli_orignator_transaction::type_id::create("wr_rsp_credit_h");

      wr_rsp_credit_h.wr_rsp_credit_vld        = `ORIG_MON_CB.wr_rsp_credit_vld;
      wr_rsp_credit_h.wr_rsp_credit_pool       = `ORIG_MON_CB.wr_rsp_credit_pool;
      wr_rsp_credit_h.wr_rsp_credit_port0_vc   = `ORIG_MON_CB.wr_rsp_credit_port0_vc;
      wr_rsp_credit_h.wr_rsp_credit_port1_vc   = `ORIG_MON_CB.wr_rsp_credit_port1_vc;
      wr_rsp_credit_h.wr_rsp_credit_port2_vc   = `ORIG_MON_CB.wr_rsp_credit_port2_vc;
      wr_rsp_credit_h.wr_rsp_credit_port3_vc   = `ORIG_MON_CB.wr_rsp_credit_port3_vc;
      wr_rsp_credit_h.wr_rsp_credit_port0_num  = `ORIG_MON_CB.wr_rsp_credit_port0_num;
      wr_rsp_credit_h.wr_rsp_credit_port1_num  = `ORIG_MON_CB.wr_rsp_credit_port1_num;
      wr_rsp_credit_h.wr_rsp_credit_port2_num  = `ORIG_MON_CB.wr_rsp_credit_port2_num;
      wr_rsp_credit_h.wr_rsp_credit_port3_num  = `ORIG_MON_CB.wr_rsp_credit_port3_num;
      wr_rsp_credit_h.wr_rsp_credit_vld_parity = `ORIG_MON_CB.wr_rsp_credit_vld_parity;
      wr_rsp_credit_h.wr_rsp_credit_parity     = `ORIG_MON_CB.wr_rsp_credit_parity;

      orignator_monitor.orig_mon_ap.write(wr_rsp_credit_h);

   end
  end

endtask: sample_wr_rsp_credit_signals

// ==================================================================
task ualink_upli_orignator_monitor_common::sample_rd_rsp_credit_signals();
  ualink_upli_orignator_transaction rd_rsp_credit_h;

  forever begin
    @(`ORIG_MON_CB);

    if (`ORIG_MON_CB.rd_rsp_credit_vld > 0) begin

      rd_rsp_credit_h = ualink_upli_orignator_transaction::type_id::create("rd_rsp_credit_h");

      rd_rsp_credit_h.rd_rsp_credit_vld        = `ORIG_MON_CB.rd_rsp_credit_vld;
      rd_rsp_credit_h.rd_rsp_credit_pool       = `ORIG_MON_CB.rd_rsp_credit_pool;
      rd_rsp_credit_h.rd_rsp_credit_port0_vc   = `ORIG_MON_CB.rd_rsp_credit_port0_vc;
      rd_rsp_credit_h.rd_rsp_credit_port1_vc   = `ORIG_MON_CB.rd_rsp_credit_port1_vc;
      rd_rsp_credit_h.rd_rsp_credit_port2_vc   = `ORIG_MON_CB.rd_rsp_credit_port2_vc;
      rd_rsp_credit_h.rd_rsp_credit_port3_vc   = `ORIG_MON_CB.rd_rsp_credit_port3_vc;
      rd_rsp_credit_h.rd_rsp_credit_port0_num  = `ORIG_MON_CB.rd_rsp_credit_port0_num;
      rd_rsp_credit_h.rd_rsp_credit_port1_num  = `ORIG_MON_CB.rd_rsp_credit_port1_num;
      rd_rsp_credit_h.rd_rsp_credit_port2_num  = `ORIG_MON_CB.rd_rsp_credit_port2_num;
      rd_rsp_credit_h.rd_rsp_credit_port3_num  = `ORIG_MON_CB.rd_rsp_credit_port3_num;
      rd_rsp_credit_h.rd_rsp_credit_vld_parity = `ORIG_MON_CB.rd_rsp_credit_vld_parity;
      rd_rsp_credit_h.rd_rsp_credit_parity     = `ORIG_MON_CB.rd_rsp_credit_parity;

      orignator_monitor.orig_mon_ap.write(rd_rsp_credit_h);

   end
  end

endtask: sample_rd_rsp_credit_signals

`endif // UALINK_UPLI_ORIGNATOR_MONITOR_COMMON_SV
