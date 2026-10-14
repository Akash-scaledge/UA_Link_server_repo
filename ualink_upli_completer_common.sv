
`ifndef UALINK_UPLI_COMPLETER_COMMON_SV
`define UALINK_UPLI_COMPLETER_COMMON_SV

typedef class ualink_upli_completer_monitor;

`define COMP_MON_CB monitor_mp.upli_completer_mon_cb

class ualink_upli_completer_common #(type MONITOR_MP = virtual ualink_upli_completer_interface.upli_comp_mon_mp)
      extends ualink_upli_common;

  // completer monitor instance
  ualink_upli_completer_monitor completer_monitor;

  // Monitor VIP modport
  protected MONITOR_MP monitor_mp;

  // UALINK transaction
  ualink_upli_completer_transaction xact;

  /**
   * CONSTRCTUR: Create a new ualink_upli_completer_common class instance.
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
   * sample_req_channel_credit to sample UPLI read response channel credit signals
   */
  extern virtual task sample_rd_rsp_channel_credit();

  /**
   * sample_comp_data_channel_credit to sample UPLI wr response channel credit signals
   */
  extern virtual task sample_wr_rsp_channel_credit();

  /**
   * sample_wr_rsp_channel to sample request channel signals
   */
  extern virtual task sample_req_channel();

  /**
   * sample_rd_rsp_channel to sample orignator data channel signals
   */
  extern virtual task sample_orig_data_channel();

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
  extern virtual function set_interface(virtual ualink_upli_completer_interface comp_vif);

endclass: ualink_upli_completer_common

// ===================================================================
function ualink_upli_completer_common::new (ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction: new

// ===================================================================
function ualink_upli_completer_common::set_interface(virtual ualink_upli_completer_interface comp_vif);
  monitor_mp = comp_vif.upli_comp_mon_mp;
endfunction: set_interface

// ===================================================================
task ualink_upli_completer_common::start();

  fork
    sample_reset_signal();
    sample_rd_rsp_channel_credit();
    sample_wr_rsp_channel_credit();
    sample_req_channel();
    sample_orig_data_channel();
  join_none

endtask: start

// ===================================================================
task ualink_upli_completer_common::update_on_reset();

  super.update_on_reset();

endtask: update_on_reset

// ===================================================================
task ualink_upli_completer_common::sample_reset_signal();

endtask: sample_reset_signal

// ===================================================================
task ualink_upli_completer_common::sample_rd_rsp_channel_credit();

  int                                    rd_rsp_credit_port_num[(2**`UPLI_MAX_RD_RSP_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_RD_RSP_VC_WIDTH-1:0]    rd_rsp_credit_port_vc[(2**`UPLI_MAX_RD_RSP_VC_WIDTH)-1:0];

  ualink_upli_completer_transaction      rd_rsp_credit_h;

  forever begin

    @(`COMP_MON_CB);

    if (`COMP_MON_CB.rd_rsp_credit_vld > 0) begin
    
      rd_rsp_credit_port_num[0] = `COMP_MON_CB.rd_rsp_credit_port0_num; 
      rd_rsp_credit_port_num[1] = `COMP_MON_CB.rd_rsp_credit_port1_num; 
      rd_rsp_credit_port_num[2] = `COMP_MON_CB.rd_rsp_credit_port2_num; 
      rd_rsp_credit_port_num[3] = `COMP_MON_CB.rd_rsp_credit_port3_num;

      rd_rsp_credit_port_vc[0]  = `COMP_MON_CB.rd_rsp_credit_port0_vc; 
      rd_rsp_credit_port_vc[1]  = `COMP_MON_CB.rd_rsp_credit_port1_vc; 
      rd_rsp_credit_port_vc[2]  = `COMP_MON_CB.rd_rsp_credit_port2_vc; 
      rd_rsp_credit_port_vc[3]  = `COMP_MON_CB.rd_rsp_credit_port3_vc; 

      for (int i =0; i <`UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH; i++) begin
        if (`COMP_MON_CB.rd_rsp_credit_vld[i]) begin
          if (`COMP_MON_CB.rd_rsp_credit_pool[i]) begin
            upli_rd_rsp_channel_credit_pool[i] += rd_rsp_credit_port_num[i] + 1;
          end 
          else begin
            upli_rd_rsp_channel_credit_vc[i][rd_rsp_credit_port_vc[i]] += rd_rsp_credit_port_num[i] + 1;
          end
        end
      end

      rd_rsp_credit_h = ualink_upli_completer_transaction::type_id::create("rd_rsp_credit_h");

      rd_rsp_credit_h.rd_rsp_credit_vld        = `COMP_MON_CB.rd_rsp_credit_vld;
      rd_rsp_credit_h.rd_rsp_credit_pool       = `COMP_MON_CB.rd_rsp_credit_pool;
      rd_rsp_credit_h.rd_rsp_credit_port0_vc   = `COMP_MON_CB.rd_rsp_credit_port0_vc;
      rd_rsp_credit_h.rd_rsp_credit_port1_vc   = `COMP_MON_CB.rd_rsp_credit_port1_vc;
      rd_rsp_credit_h.rd_rsp_credit_port2_vc   = `COMP_MON_CB.rd_rsp_credit_port2_vc;
      rd_rsp_credit_h.rd_rsp_credit_port3_vc   = `COMP_MON_CB.rd_rsp_credit_port3_vc;
      rd_rsp_credit_h.rd_rsp_credit_port0_num  = `COMP_MON_CB.rd_rsp_credit_port0_num;
      rd_rsp_credit_h.rd_rsp_credit_port1_num  = `COMP_MON_CB.rd_rsp_credit_port1_num;
      rd_rsp_credit_h.rd_rsp_credit_port2_num  = `COMP_MON_CB.rd_rsp_credit_port2_num;
      rd_rsp_credit_h.rd_rsp_credit_port3_num  = `COMP_MON_CB.rd_rsp_credit_port3_num;
      rd_rsp_credit_h.rd_rsp_credit_vld_parity = `COMP_MON_CB.rd_rsp_credit_vld_parity;
      rd_rsp_credit_h.rd_rsp_credit_parity     = `COMP_MON_CB.rd_rsp_credit_parity;

      completer_monitor.comp_mon_ap.write(rd_rsp_credit_h);
    end
    upli_rd_rsp_channel_credit_init_done = `COMP_MON_CB.rd_rsp_credit_init_done;
  end

endtask: sample_rd_rsp_channel_credit

// ===================================================================
task ualink_upli_completer_common::sample_wr_rsp_channel_credit();

  int                                    wr_rsp_credit_port_num[(2**`UPLI_MAX_WR_RSP_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_WR_RSP_VC_WIDTH-1:0]    wr_rsp_credit_port_vc[(2**`UPLI_MAX_WR_RSP_VC_WIDTH)-1:0];

  ualink_upli_completer_transaction      wr_rsp_credit_h;

  forever begin

    @(`COMP_MON_CB);

    if (`COMP_MON_CB.wr_rsp_credit_vld > 0) begin
    
      wr_rsp_credit_port_num[0] = `COMP_MON_CB.wr_rsp_credit_port0_num; 
      wr_rsp_credit_port_num[1] = `COMP_MON_CB.wr_rsp_credit_port1_num; 
      wr_rsp_credit_port_num[2] = `COMP_MON_CB.wr_rsp_credit_port2_num; 
      wr_rsp_credit_port_num[3] = `COMP_MON_CB.wr_rsp_credit_port3_num;

      wr_rsp_credit_port_vc[0]  = `COMP_MON_CB.wr_rsp_credit_port0_vc; 
      wr_rsp_credit_port_vc[1]  = `COMP_MON_CB.wr_rsp_credit_port1_vc; 
      wr_rsp_credit_port_vc[2]  = `COMP_MON_CB.wr_rsp_credit_port2_vc; 
      wr_rsp_credit_port_vc[3]  = `COMP_MON_CB.wr_rsp_credit_port3_vc; 

      for (int i =0; i <`UPLI_MAX_ORIG_DATA_CREDIT_VLD_WIDTH; i++) begin
        if (`COMP_MON_CB.wr_rsp_credit_vld[i]) begin
          if (`COMP_MON_CB.wr_rsp_credit_pool[i]) begin
            upli_wr_rsp_channel_credit_pool[i] += wr_rsp_credit_port_num[i] + 1;
          end 
          else begin
            upli_wr_rsp_channel_credit_vc[i][wr_rsp_credit_port_vc[i]] += wr_rsp_credit_port_num[i] + 1;
          end
        end
      end

      wr_rsp_credit_h = ualink_upli_completer_transaction::type_id::create("wr_rsp_credit_h");

      wr_rsp_credit_h.wr_rsp_credit_vld        = `COMP_MON_CB.wr_rsp_credit_vld;
      wr_rsp_credit_h.wr_rsp_credit_pool       = `COMP_MON_CB.wr_rsp_credit_pool;
      wr_rsp_credit_h.wr_rsp_credit_port0_vc   = `COMP_MON_CB.wr_rsp_credit_port0_vc;
      wr_rsp_credit_h.wr_rsp_credit_port1_vc   = `COMP_MON_CB.wr_rsp_credit_port1_vc;
      wr_rsp_credit_h.wr_rsp_credit_port2_vc   = `COMP_MON_CB.wr_rsp_credit_port2_vc;
      wr_rsp_credit_h.wr_rsp_credit_port3_vc   = `COMP_MON_CB.wr_rsp_credit_port3_vc;
      wr_rsp_credit_h.wr_rsp_credit_port0_num  = `COMP_MON_CB.wr_rsp_credit_port0_num;
      wr_rsp_credit_h.wr_rsp_credit_port1_num  = `COMP_MON_CB.wr_rsp_credit_port1_num;
      wr_rsp_credit_h.wr_rsp_credit_port2_num  = `COMP_MON_CB.wr_rsp_credit_port2_num;
      wr_rsp_credit_h.wr_rsp_credit_port3_num  = `COMP_MON_CB.wr_rsp_credit_port3_num;
      wr_rsp_credit_h.wr_rsp_credit_vld_parity = `COMP_MON_CB.wr_rsp_credit_vld_parity;
      wr_rsp_credit_h.wr_rsp_credit_parity     = `COMP_MON_CB.wr_rsp_credit_parity;

      completer_monitor.comp_mon_ap.write(wr_rsp_credit_h);

    end
    upli_wr_rsp_channel_credit_init_done = `COMP_MON_CB.wr_rsp_credit_init_done;
  end

endtask: sample_wr_rsp_channel_credit

// ===================================================================
task ualink_upli_completer_common::sample_req_channel();
  ualink_upli_completer_transaction req_channel_req_h;

  forever begin

    @(`COMP_MON_CB);

    if (`COMP_MON_CB.req_valid) begin
      req_channel_req_h = ualink_upli_completer_transaction::type_id::create("req_channel_req_h");

      req_channel_req_h.req_vld              = 1; 
      req_channel_req_h.req_port_id          = `COMP_MON_CB.req_port_id; 
      req_channel_req_h.req_asi              = `COMP_MON_CB.req_asi; 
      req_channel_req_h.req_auth_tag         = `COMP_MON_CB.req_auth_tag; 
      req_channel_req_h.req_src_phys_acc_id  = `COMP_MON_CB.req_src_phys_acc_id; 
      req_channel_req_h.req_dst_phys_acc_id  = `COMP_MON_CB.req_dst_phys_acc_id; 
      req_channel_req_h.req_tag              = `COMP_MON_CB.req_tag; 
      req_channel_req_h.req_num_beats        = `COMP_MON_CB.req_num_beats;
      req_channel_req_h.req_addr             = `COMP_MON_CB.req_addr;
      req_channel_req_h.req_cmd              = `COMP_MON_CB.req_cmd;
      req_channel_req_h.req_len              = `COMP_MON_CB.req_len;
      req_channel_req_h.req_attr             = `COMP_MON_CB.req_attr;
      req_channel_req_h.req_meta_data        = `COMP_MON_CB.req_meta_data;
      req_channel_req_h.req_vc               = `COMP_MON_CB.req_vc;
      req_channel_req_h.req_pool             = `COMP_MON_CB.req_pool;

      completer_monitor.comp_mon_ap.write(req_channel_req_h);  
    end
  end

endtask: sample_req_channel

// ===================================================================
task ualink_upli_completer_common::sample_orig_data_channel();

  ualink_upli_completer_transaction orig_data_channel_h;

  forever begin

    @(`COMP_MON_CB);

    if (`COMP_MON_CB.orig_data_vld) begin 
      orig_data_channel_h = ualink_upli_completer_transaction::type_id::create("orig_data_channel_h");

      orig_data_channel_h.orig_data_vld     = 1;
      orig_data_channel_h.orig_data_port_id = `COMP_MON_CB.orig_data_port_id;
      orig_data_channel_h.orig_data_offset  = `COMP_MON_CB.orig_data_offset;
      orig_data_channel_h.orig_data_last    = `COMP_MON_CB.orig_data_last;
      orig_data_channel_h.orig_data_error   = `COMP_MON_CB.orig_data_error;
      orig_data_channel_h.orig_data_vc      = `COMP_MON_CB.orig_data_vc;
      orig_data_channel_h.orig_data_pool    = `COMP_MON_CB.orig_data_pool;
      orig_data_channel_h.orig_data.push_back(`COMP_MON_CB.orig_data);
      orig_data_channel_h.orig_data_byte_en.push_back(`COMP_MON_CB.orig_data_byte_en);

      completer_monitor.comp_mon_ap.write(orig_data_channel_h); 
    end
  end

endtask: sample_orig_data_channel

`endif // UALINK_UPLI_COMPLETER_COMMON_SV
