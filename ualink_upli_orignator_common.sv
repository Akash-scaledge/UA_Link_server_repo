
`ifndef UALINK_UPLI_ORIGNATOR_COMMON_SV
`define UALINK_UPLI_ORIGNATOR_COMMON_SV

typedef class ualink_upli_originator_monitor;
`define ORIG_MON_CB monitor_mp.upli_orignator_mon_cb

class ualink_upli_orignator_common #(type MONITOR_MP = virtual ualink_upli_orignator_interface.upli_orig_mon_mp)
      extends ualink_upli_common;

  // Orignator monitor instance
  ualink_upli_originator_monitor orignator_monitor;

  // Monitor VIP modport
  protected MONITOR_MP monitor_mp;

  // UALINK transaction
  ualink_upli_orignator_transaction xact;

  /**
   * CONSTRCTUR: Create a new ualink_upli_orignator_common class instance.
   *
   * @param cfg ualink_upli_config config class handle
   * @param reporter uvm_report_object class handle
   */
  extern function new(ualink_upli_config cfg, uvm_report_object reporter);

  /**
   * sample_reset_signal to sample reset signals
   */
  extern virtual task sample_reset_signal();

  /**
   * sample_req_channel_credit to sample UPLI request channel credit signals
   */
  extern virtual task sample_req_channel_credit();

  /**
   * sample_orig_data_channel_credit to sample UPLI Orignator and Data channel credit signals
   */
  extern virtual task sample_orig_data_channel_credit();

  /**
   * sample_wr_rsp_channel to sample write response channel signals
   */
  extern virtual task sample_wr_rsp_channel();

  /**
   * sample_rd_rsp_channel to sample read response and data channel signals
   */
  extern virtual task sample_rd_rsp_channel();

  /**
   * start to start all the process
   */
  extern virtual task start();

  /**
   * update_on_reset to reset all the variables of this class when reset asserted.
   */
  extern virtual task update_on_reset();

  /**
   * set_interface to set all the virtual interfaces.
   */
  extern virtual function set_interface(virtual ualink_upli_orignator_interface orig_vif);

  /**
   * set_interface to set all the virtual interfaces.
   */
  extern virtual task sample_interface_handshake_signals();

endclass: ualink_upli_orignator_common

// ===================================================================
function ualink_upli_orignator_common::new (ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction: new

// ===================================================================
function ualink_upli_orignator_common::set_interface(virtual ualink_upli_orignator_interface orig_vif);
  monitor_mp = orig_vif.upli_orig_mon_mp;
endfunction: set_interface

// ===================================================================
task ualink_upli_orignator_common::start();

  fork
    sample_reset_signal();
    sample_interface_handshake_signals();
    sample_req_channel_credit();
    sample_orig_data_channel_credit();
    sample_wr_rsp_channel();
    sample_rd_rsp_channel();
  join_none

endtask: start

// ===================================================================
task ualink_upli_orignator_common::update_on_reset();

  super.update_on_reset();

endtask: update_on_reset

// ===================================================================
task ualink_upli_orignator_common::sample_reset_signal();

  forever begin
    @(negedge monitor_mp.upli_resetn);
    is_reset = 1;
    @(posedge monitor_mp.upli_resetn);
    is_reset = 0;
  end

endtask: sample_reset_signal

// ===================================================================
task ualink_upli_orignator_common::sample_interface_handshake_signals();

  forever @(`ORIG_MON_CB.orig_clk_req, `ORIG_MON_CB.comp_clk_ack, `ORIG_MON_CB.comp_clk_req, `ORIG_MON_CB.orig_clk_ack) begin
    is_orig_if_handshake_done = `ORIG_MON_CB.orig_clk_req && `ORIG_MON_CB.comp_clk_ack;
    is_comp_if_handshake_done = `ORIG_MON_CB.comp_clk_req && `ORIG_MON_CB.orig_clk_ack;
  end

endtask: sample_interface_handshake_signals
// ===================================================================
task ualink_upli_orignator_common::sample_req_channel_credit();

  int                              req_credit_port_num[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_REQ_VC_WIDTH-1:0] req_credit_port_vc[(2**`UPLI_MAX_REQ_VC_WIDTH)-1:0];
  
  ualink_upli_orignator_transaction      req_credit_h;

  forever begin

    @(`ORIG_MON_CB);

    if(`ORIG_MON_CB.req_credit_vld > 0) begin
      req_credit_port_num[0] = `ORIG_MON_CB.req_credit_port0_num;
      req_credit_port_num[1] = `ORIG_MON_CB.req_credit_port1_num;
      req_credit_port_num[2] = `ORIG_MON_CB.req_credit_port2_num;
      req_credit_port_num[3] = `ORIG_MON_CB.req_credit_port3_num;

      req_credit_port_vc[0]  = `ORIG_MON_CB.req_credit_port0_vc;
      req_credit_port_vc[1]  = `ORIG_MON_CB.req_credit_port1_vc;
      req_credit_port_vc[2]  = `ORIG_MON_CB.req_credit_port2_vc;
      req_credit_port_vc[3]  = `ORIG_MON_CB.req_credit_port3_vc;

      for(int i =0; i<`UPLI_MAX_REQ_CREDIT_VLD_WIDTH; i++) begin
        if(`ORIG_MON_CB.req_credit_vld[i] == 1) begin
          if(`ORIG_MON_CB.req_credit_pool[i] == 1) begin
            upli_req_channel_credit_pool[i] += req_credit_port_num[i] + 1;
          end
          else begin
            upli_req_channel_credit_vc[i][req_credit_port_vc[i]] += req_credit_port_num[i] + 1;
          end
        end
      end

      req_credit_h = ualink_upli_orignator_transaction::type_id::create("req_credit_h");

      req_credit_h.req_credit_vld        = `ORIG_MON_CB.req_credit_vld;
      req_credit_h.req_credit_pool       = `ORIG_MON_CB.req_credit_pool;
      req_credit_h.req_credit_port0_vc   = `ORIG_MON_CB.req_credit_port0_vc;
      req_credit_h.req_credit_port1_vc   = `ORIG_MON_CB.req_credit_port1_vc;
      req_credit_h.req_credit_port2_vc   = `ORIG_MON_CB.req_credit_port2_vc;
      req_credit_h.req_credit_port3_vc   = `ORIG_MON_CB.req_credit_port3_vc;
      req_credit_h.req_credit_port0_num  = `ORIG_MON_CB.req_credit_port0_num;
      req_credit_h.req_credit_port1_num  = `ORIG_MON_CB.req_credit_port1_num;
      req_credit_h.req_credit_port2_num  = `ORIG_MON_CB.req_credit_port2_num;
      req_credit_h.req_credit_port3_num  = `ORIG_MON_CB.req_credit_port3_num;
      req_credit_h.req_credit_vld_parity = `ORIG_MON_CB.req_credit_vld_parity;
      req_credit_h.req_credit_parity     = `ORIG_MON_CB.req_credit_parity;

      orignator_monitor.orig_mon_ap.write(req_credit_h);

    end
    upli_req_channel_credit_init_done = `ORIG_MON_CB.req_credit_init_done;
  end // forever

endtask: sample_req_channel_credit

// ===================================================================
task ualink_upli_orignator_common::sample_orig_data_channel_credit();

  int                                    orig_data_credit_port_num[(2**`UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_ORIG_DATA_VC_WIDTH-1:0] orig_data_credit_port_vc[(2**`UPLI_MAX_ORIG_DATA_VC_WIDTH)-1:0];

  ualink_upli_orignator_transaction      orig_data_credit_h;

  forever begin

    @(`ORIG_MON_CB);

    if(`ORIG_MON_CB.orig_data_credit_vld > 0) begin
      orig_data_credit_port_num[0] = `ORIG_MON_CB.orig_data_credit_port0_num;
      orig_data_credit_port_num[1] = `ORIG_MON_CB.orig_data_credit_port1_num;
      orig_data_credit_port_num[2] = `ORIG_MON_CB.orig_data_credit_port2_num;
      orig_data_credit_port_num[3] = `ORIG_MON_CB.orig_data_credit_port3_num;

      orig_data_credit_port_vc[0]  = `ORIG_MON_CB.orig_data_credit_port0_vc;
      orig_data_credit_port_vc[1]  = `ORIG_MON_CB.orig_data_credit_port1_vc;
      orig_data_credit_port_vc[2]  = `ORIG_MON_CB.orig_data_credit_port2_vc;
      orig_data_credit_port_vc[3]  = `ORIG_MON_CB.orig_data_credit_port3_vc;

      for(int i =0; i<`UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH; i++) begin
        if(`ORIG_MON_CB.orig_data_credit_vld[i] == 1) begin
          if(`ORIG_MON_CB.orig_data_credit_pool[i] == 1) begin
            upli_orig_data_channel_credit_pool[i] += orig_data_credit_port_num[i] + 1;
          end
          else begin
            upli_orig_data_channel_credit_vc[i][orig_data_credit_port_vc[i]] += orig_data_credit_port_num[i] + 1;
          end
        end
      end


      orig_data_credit_h = ualink_upli_orignator_transaction::type_id::create("orig_data_credit_h");

      orig_data_credit_h.orig_data_credit_vld        = `ORIG_MON_CB.orig_data_credit_vld;
      orig_data_credit_h.orig_data_credit_pool       = `ORIG_MON_CB.orig_data_credit_pool;
      orig_data_credit_h.orig_data_credit_port0_vc   = `ORIG_MON_CB.orig_data_credit_port0_vc;
      orig_data_credit_h.orig_data_credit_port1_vc   = `ORIG_MON_CB.orig_data_credit_port1_vc;
      orig_data_credit_h.orig_data_credit_port2_vc   = `ORIG_MON_CB.orig_data_credit_port2_vc;
      orig_data_credit_h.orig_data_credit_port3_vc   = `ORIG_MON_CB.orig_data_credit_port3_vc;
      orig_data_credit_h.orig_data_credit_port0_num  = `ORIG_MON_CB.orig_data_credit_port0_num;
      orig_data_credit_h.orig_data_credit_port1_num  = `ORIG_MON_CB.orig_data_credit_port1_num;
      orig_data_credit_h.orig_data_credit_port2_num  = `ORIG_MON_CB.orig_data_credit_port2_num;
      orig_data_credit_h.orig_data_credit_port3_num  = `ORIG_MON_CB.orig_data_credit_port3_num;
      orig_data_credit_h.orig_data_credit_vld_parity = `ORIG_MON_CB.orig_data_credit_vld_parity;
      orig_data_credit_h.orig_data_credit_parity     = `ORIG_MON_CB.orig_data_credit_parity;

      orignator_monitor.orig_mon_ap.write(orig_data_credit_h);

    end
    upli_orig_data_channel_credit_init_done = `ORIG_MON_CB.orig_data_credit_init_done;
  end // forever

endtask: sample_orig_data_channel_credit

// ===================================================================
task ualink_upli_orignator_common::sample_wr_rsp_channel();

  ualink_upli_orignator_transaction wr_rsp_channel_h;

  forever begin
    @(`ORIG_MON_CB);
    if (`ORIG_MON_CB.wr_rsp_vld) begin
      wr_rsp_channel_h = ualink_upli_orignator_transaction::type_id::create("wr_rsp_channel_h");
      wr_rsp_channel_h.wr_rsp_vld             = `ORIG_MON_CB.wr_rsp_vld;
      wr_rsp_channel_h.wr_rsp_port_id         = `ORIG_MON_CB.wr_rsp_port_id;
      wr_rsp_channel_h.wr_rsp_auth_tag        = `ORIG_MON_CB.wr_rsp_auth_tag;
      wr_rsp_channel_h.wr_rsp_src_phys_acc_id = `ORIG_MON_CB.wr_rsp_src_phys_acc_id;
      wr_rsp_channel_h.wr_rsp_dst_phys_acc_id = `ORIG_MON_CB.wr_rsp_dst_phys_acc_id;
      wr_rsp_channel_h.wr_rsp_tag             = `ORIG_MON_CB.wr_rsp_tag;
      wr_rsp_channel_h.wr_rsp_status          = `ORIG_MON_CB.wr_rsp_status;
      wr_rsp_channel_h.wr_rsp_pool            = `ORIG_MON_CB.wr_rsp_pool;
      wr_rsp_channel_h.wr_rsp_vc              = `ORIG_MON_CB.wr_rsp_vc;
      wr_rsp_channel_h.wr_rsp_vld_parity      = `ORIG_MON_CB.wr_rsp_vld_parity;
      wr_rsp_channel_h.wr_rsp_parity          = `ORIG_MON_CB.wr_rsp_parity;

      orignator_monitor.orig_mon_ap.write(wr_rsp_channel_h);

      if (wr_rsp_channel_h.wr_rsp_pool) begin
        upli_wr_rsp_channel_credit_pool[wr_rsp_channel_h.wr_rsp_port_id]--;
      end
      else begin
        upli_wr_rsp_channel_credit_vc[wr_rsp_channel_h.wr_rsp_port_id][wr_rsp_channel_h.wr_rsp_vc]--;
      end
    end
  end

endtask: sample_wr_rsp_channel

// ===================================================================
task ualink_upli_orignator_common::sample_rd_rsp_channel();

  ualink_upli_orignator_transaction rd_rsp_channel_h;

  forever begin
    @(`ORIG_MON_CB);
    if (`ORIG_MON_CB.rd_rsp_vld) begin
      rd_rsp_channel_h = ualink_upli_orignator_transaction::type_id::create("rd_rsp_channel_h");
      rd_rsp_channel_h.rd_rsp_vld             = `ORIG_MON_CB.rd_rsp_vld;
      rd_rsp_channel_h.rd_rsp_port_id         = `ORIG_MON_CB.rd_rsp_port_id;
      rd_rsp_channel_h.rd_rsp_auth_tag        = `ORIG_MON_CB.rd_rsp_auth_tag;
      rd_rsp_channel_h.rd_rsp_src_phys_acc_id = `ORIG_MON_CB.rd_rsp_src_phys_acc_id;
      rd_rsp_channel_h.rd_rsp_dst_phys_acc_id = `ORIG_MON_CB.rd_rsp_dst_phys_acc_id;
      rd_rsp_channel_h.rd_rsp_tag             = `ORIG_MON_CB.rd_rsp_tag;
      rd_rsp_channel_h.rd_rsp_status          = `ORIG_MON_CB.rd_rsp_status;
      rd_rsp_channel_h.rd_rsp_pool            = `ORIG_MON_CB.rd_rsp_pool;
      rd_rsp_channel_h.rd_rsp_vc              = `ORIG_MON_CB.rd_rsp_vc;
      rd_rsp_channel_h.rd_rsp_vld_parity      = `ORIG_MON_CB.rd_rsp_vld_parity;
      rd_rsp_channel_h.rd_rsp_parity          = `ORIG_MON_CB.rd_rsp_parity;

      orignator_monitor.orig_mon_ap.write(rd_rsp_channel_h);

      if (rd_rsp_channel_h.rd_rsp_pool) begin
        upli_rd_rsp_channel_credit_pool[rd_rsp_channel_h.rd_rsp_port_id]--;
      end
      else begin
        upli_rd_rsp_channel_credit_vc[rd_rsp_channel_h.rd_rsp_port_id][rd_rsp_channel_h.rd_rsp_vc]--;
      end
    end
  end
endtask: sample_rd_rsp_channel

`endif // UALINK_UPLI_ORIGNATOR_COMMON_SV
