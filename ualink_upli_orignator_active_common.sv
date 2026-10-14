
`ifndef UALINK_UPLI_ORIGNATOR_ACTIVE_COMMON_SV
`define UALINK_UPLI_ORIGNATOR_ACTIVE_COMMON_SV

typedef class ualink_upli_originator_driver;
`define ORIG_DRV_CB driver_mp.upli_orignator_drv_cb

class ualink_upli_orignator_active_common #(
    type DRIVER_MP = virtual ualink_upli_orignator_interface.upli_orig_drv_mp,
    type MONITOR_MP = virtual ualink_upli_orignator_interface.upli_orig_mon_mp)
    extends ualink_upli_orignator_common #(MONITOR_MP);

  // Driver modport for Orignator.
  protected DRIVER_MP driver_mp;

  // ualink_upli_originator_driver driver handle.
  ualink_upli_originator_driver driver;

  //Queue to store UPLI Request
  ualink_upli_orignator_transaction upli_req_q[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0][$];

  //Queue to store UPLI Write Data
  ualink_upli_orignator_transaction upli_req_data_q[`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0];

  //Queue to store UPLI Write response credit update packet
  ualink_upli_orignator_transaction upli_wr_rsp_credit_q[$];

  //Queue to store UPLI Read response credit update packet
  ualink_upli_orignator_transaction upli_rd_rsp_credit_q[$];

  // Current TDM port value.
  bit [`UPLI_MAX_REQ_PORT_ID_WIDTH-1:0] current_tdm_val;

  // TO check TDM set as per first request port_id or not.
  bit tdm_set_to_port_id_after_reset = 0;

  /**
   * CONSTRCTUR: Create a new ualink_upli_orignator_active_common class instance.
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
   * drive_req_channel to drive request channel signals
   */
  extern virtual task drive_req_channel();

  /**
   * drive_orig_data_channel to drive origantor data channel signals
   */
  extern virtual task drive_orig_data_channel();

  /**
   * drive_wr_rsp_credits to drive write response channel credit signals
   */
  extern virtual task drive_wr_rsp_credits();

  /**
   * drive_rd_rsp_credits to drive read response and data channel credit signals
   */
  extern virtual task drive_rd_rsp_credits();

  /**
   * interface_connection_handshake to do UPLI interface connection handshake.
   */
  extern virtual task interface_connection_handshake();

  /**
   * set_interface to set all the virtual interfaces.
   */
  extern virtual function set_interface(virtual ualink_upli_orignator_interface orig_vif);

  /**
   * check_credit_to_send_req to check credit of request and orignator data based on request type before driving request to interface.
   */
  extern virtual function bit check_credit_to_send_req(ualink_upli_orignator_transaction xact);

endclass: ualink_upli_orignator_active_common

// ==================================================================
function ualink_upli_orignator_active_common::new (ualink_upli_config cfg, uvm_report_object reporter);
  super.new(cfg, reporter);
endfunction : new

// ==================================================================
function ualink_upli_orignator_active_common::set_interface(virtual ualink_upli_orignator_interface orig_vif);
  super.set_interface(orig_vif);
  driver_mp = orig_vif.upli_orig_drv_mp;
endfunction: set_interface

// ==================================================================
task ualink_upli_orignator_active_common::start();

  super.start();

  fork
    interface_connection_handshake();
    drive_req_channel();
    drive_orig_data_channel();
    drive_wr_rsp_credits();
    drive_rd_rsp_credits();
  join_none

  wait fork;
endtask: start

// ==================================================================
task ualink_upli_orignator_active_common::async_init_signals();

endtask: async_init_signals

// ==================================================================
task ualink_upli_orignator_active_common::initialize_signals();

endtask: initialize_signals

// ==================================================================
task ualink_upli_orignator_active_common::update_on_reset();

  super.update_on_reset();

  foreach (upli_req_q[i]) upli_req_q[i].delete();
  foreach (upli_req_data_q[i]) upli_req_data_q[i] = null;

  upli_wr_rsp_credit_q.delete();
  upli_rd_rsp_credit_q.delete();

  current_tdm_val = 0;
  tdm_set_to_port_id_after_reset = 0;

endtask: update_on_reset

// ==================================================================
function ualink_upli_orignator_active_common::drive_xact(ualink_upli_transaction xact);

  ualink_upli_orignator_transaction req;

  $cast(req, xact.clone());
  req.set_id_info(xact);

  if (req.is_credit_update_pkt() && (cfg.send_credit_auto == 0)) begin
    if (req.is_wr_rsp_credit_update_pkt) upli_wr_rsp_credit_q.push_back(req);
    if (req.is_rd_rsp_credit_update_pkt) upli_rd_rsp_credit_q.push_back(req);
  end

  if (req.is_request_pkt()) begin
    // If it's first request after reset, set the current TDM value.
    if (tdm_set_to_port_id_after_reset == 0) begin 
      current_tdm_val = req.req_port_id;
      tdm_set_to_port_id_after_reset = 1;
    end
    upli_req_q[req.req_port_id].push_back(req);
  end

endfunction: drive_xact

// ==================================================================
task ualink_upli_orignator_active_common::interface_connection_handshake();

  fork
    begin
      `ORIG_DRV_CB.orig_clk_req <= 1;
      wait (`ORIG_DRV_CB.comp_clk_ack == 1);
    end

    begin
      wait(`ORIG_DRV_CB.comp_clk_req == 1);
      `ORIG_DRV_CB.orig_clk_ack <= 1;
    end
  join

endtask: interface_connection_handshake

// ==================================================================
task ualink_upli_orignator_active_common::drive_req_channel();

  ualink_upli_orignator_transaction xact;

  forever begin

    // Wait for initail request after reset to set TDM port value and
    // Interface handshake to complete before initiating any request.
    wait((tdm_set_to_port_id_after_reset == 1) && (is_orig_if_handshake_done == 1));

    if (upli_req_q[current_tdm_val].size() > 0) begin
      xact = upli_req_q[current_tdm_val].pop_front();
      if (xact.is_write_cmd() || xact.is_atomic_cmd()) begin
        if(upli_req_data_q[current_tdm_val] == null) begin
          if (check_credit_to_send_req(xact)) begin
            upli_req_data_q[current_tdm_val] = xact;
          end
          else begin
            upli_req_q[current_tdm_val].push_front(xact);
            xact = null;
          end
        end
      end
      else begin
        if (check_credit_to_send_req(xact) == 0) begin
          upli_req_q[current_tdm_val].push_front(xact);
          xact = null;
        end
      end
    end

    // if xact != null then drive request to the request channel
    if (xact != null) begin
      `ORIG_DRV_CB.req_port_id         <= xact.req_port_id &
                                          ( {`UPLI_MAX_REQ_PORT_ID_WIDTH{1'b1}} >>
                                            (`UPLI_MAX_REQ_PORT_ID_WIDTH - cfg.req_port_id_width) );
      `ORIG_DRV_CB.req_asi             <= xact.req_asi &
                                          ( {`UPLI_MAX_REQ_ASI_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_ASI_WIDTH - cfg.req_asi_width ));
      `ORIG_DRV_CB.req_auth_tag        <= xact.req_auth_tag &
                                          ( {`UPLI_MAX_REQ_AUTH_TAG_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_AUTH_TAG_WIDTH - cfg.req_auth_tag_width) );
      `ORIG_DRV_CB.req_src_phys_acc_id <= xact.req_src_phys_acc_id &
                                          ( {`UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_SRC_PHYS_ACC_ID_WIDTH -
                                            cfg.req_src_phys_acc_id_width) );
      `ORIG_DRV_CB.req_dst_phys_acc_id <= xact.req_dst_phys_acc_id &
                                          ( {`UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_DST_PHYS_ACC_ID_WIDTH -
                                            cfg.req_dst_phys_acc_id_width ));
      `ORIG_DRV_CB.req_tag             <= xact.req_tag &
                                          ( {`UPLI_MAX_REQ_TAG_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_TAG_WIDTH - cfg.req_tag_width));
      `ORIG_DRV_CB.req_num_beats       <= xact.req_num_beats &
                                          ({`UPLI_MAX_REQ_NUM_BEATS_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_NUM_BEATS_WIDTH - cfg.req_num_beats_width));
      `ORIG_DRV_CB.req_addr            <= xact.req_addr &
                                          ( {`UPLI_MAX_REQ_ADDR_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_ADDR_WIDTH - cfg.req_addr_width));
      `ORIG_DRV_CB.req_cmd             <= xact.req_cmd &
                                          ( {`UPLI_MAX_REQ_CMD_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_CMD_WIDTH - cfg.req_cmd_width));
      `ORIG_DRV_CB.req_len             <= xact.req_len &
                                          ( {`UPLI_MAX_REQ_LEN_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_LEN_WIDTH - cfg.req_len_width));
      `ORIG_DRV_CB.req_attr            <= xact.req_attr &
                                          ( {`UPLI_MAX_REQ_ATTR_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_ATTR_WIDTH - cfg.req_attr_width));
      `ORIG_DRV_CB.req_meta_data       <= xact.req_meta_data &
                                          ( {`UPLI_MAX_REQ_META_DATA_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_META_DATA_WIDTH - cfg.req_meta_data_width));
      `ORIG_DRV_CB.req_vc              <= xact.req_vc &
                                          ({`UPLI_MAX_REQ_VC_WIDTH{1'b1}} >>
                                           (`UPLI_MAX_REQ_VC_WIDTH - cfg.req_vc_width));
      `ORIG_DRV_CB.req_pool            <= xact.req_pool;
      `ORIG_DRV_CB.req_valid           <= 1'b1;
      @(`ORIG_DRV_CB);
      `ORIG_DRV_CB.req_valid           <= 1'b0;
      xact = null;
    end
    else begin
      @(`ORIG_DRV_CB);
    end

    // Update TDB to next TDM port value
    case (cfg.bifurgation_mode)
      UPLI_BIF_X4_1: begin
        current_tdm_val= 0;
      end
      UPLI_BIF_X2_2: begin
        if (current_tdm_val == 1) current_tdm_val = 0;
        else current_tdm_val++;
      end
      UPLI_BIF_X1_4: begin
        if (current_tdm_val == 3) current_tdm_val = 0;
        else current_tdm_val++;
      end
    endcase

  end

endtask: drive_req_channel

// ==================================================================
task ualink_upli_orignator_active_common::drive_orig_data_channel();

  ualink_upli_orignator_transaction xact;

  forever begin

    wait( (tdm_set_to_port_id_after_reset == 1) && (is_orig_if_handshake_done == 1) );

    if (upli_req_data_q[current_tdm_val] != null) begin
      xact = upli_req_data_q[current_tdm_val];
    end

    if (xact != null) begin
      `ORIG_DRV_CB.orig_data_port_id <= xact.orig_data_port_id &
                                        ( {`UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH{1'b1}} >>
                                         (`UPLI_MAX_ORIG_DATA_PORT_ID_WIDTH -
                                          cfg.orig_data_port_id_width) );

      `ORIG_DRV_CB.orig_data         <= xact.orig_data.pop_front() &
                                        ( {`UPLI_MAX_ORIG_DATA_WIDTH{1'b1}} >>
                                         (`UPLI_MAX_ORIG_DATA_WIDTH -
                                          cfg.orig_data_width) );

      `ORIG_DRV_CB.orig_data_byte_en <= xact.orig_data_byte_en.pop_front() &
                                        ( {`UPLI_MAX_ORIG_DATA_WIDTH/8{1'b1}} >>
                                         (`UPLI_MAX_ORIG_DATA_WIDTH/8 -
                                          cfg.orig_data_byte_en_width) );

      `ORIG_DRV_CB.orig_data_vc      <= xact.orig_data_vc &
                                        ( {`UPLI_MAX_ORIG_DATA_VC_WIDTH{1'b1}} >>
                                         (`UPLI_MAX_ORIG_DATA_VC_WIDTH -
                                          cfg.orig_data_vc_width) );

      `ORIG_DRV_CB.orig_data_last    <= xact.orig_data.size() == 0 ? 1'b1 : 1'b0;

      `ORIG_DRV_CB.orig_data_error   <= xact.orig_data_error;
      `ORIG_DRV_CB.orig_data_pool    <= xact.orig_data_pool;

      `ORIG_DRV_CB.orig_data_vld     <= 1'b1;
      @(`ORIG_DRV_CB);
      `ORIG_DRV_CB.orig_data_vld     <= 1'b0;

      if (xact.orig_data.size() == 0) upli_req_data_q[current_tdm_val] = null;
      xact = null;
    end
    else begin
      @(`ORIG_DRV_CB);
    end
  end

endtask: drive_orig_data_channel

// ==================================================================
task ualink_upli_orignator_active_common::drive_wr_rsp_credits();

  bit [`UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH-1:0] wr_rsp_pool_or_vc_credit_to_send;
  bit [`UPLI_MAX_WR_RSP_CREDIT_POOL_WIDTH-1:0] wr_rsp_credit_vld;
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT0_NUM_WIDTH-1:0] wr_rsp_credit_num[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH-1:0] wr_rsp_credit_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  bit credit_init_done_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_WR_RSP_CREDIT_PORT0_VC_WIDTH-1:0] credit_init_done_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  ualink_upli_orignator_transaction xact;

  forever begin

    if (cfg.send_credit_auto) begin
      for (int port_id = 0; port_id < 2**cfg.req_port_id_width; port_id++) begin
        // Send pool credit first
        if(cfg.max_number_of_pool_wr_rsp_credit[port_id] > upli_wr_rsp_channel_credit_pool[port_id]) begin
          wr_rsp_pool_or_vc_credit_to_send[port_id] = 1;
          if ( (cfg.max_number_of_pool_wr_rsp_credit[port_id] - upli_wr_rsp_channel_credit_pool[port_id]) > (2**cfg.wr_rsp_credit_port_num_width)) begin
            wr_rsp_credit_num[port_id] = 2**cfg.wr_rsp_credit_port_num_width;
            upli_wr_rsp_channel_credit_pool[port_id] += 2**cfg.wr_rsp_credit_port_num_width;
          end
          else begin
            wr_rsp_credit_num[port_id] = cfg.max_number_of_pool_wr_rsp_credit[port_id] - upli_wr_rsp_channel_credit_pool[port_id];
            upli_wr_rsp_channel_credit_pool[port_id] += cfg.max_number_of_pool_wr_rsp_credit[port_id] - upli_wr_rsp_channel_credit_pool[port_id];
            credit_init_done_pool[port_id] = 1;
          end
          wr_rsp_credit_vld[port_id] = 1;
        end
        else begin
          // Send VC credit per port
          for (int vc_num = 0; vc_num < (2**cfg.req_vc_width); vc_num++) begin
            if(cfg.max_number_of_vc_wr_rsp_credit[port_id][vc_num] > upli_wr_rsp_channel_credit_vc[port_id][vc_num]) begin
              wr_rsp_pool_or_vc_credit_to_send[port_id] = 0;
              wr_rsp_credit_vc[port_id] = vc_num;
              if ( (cfg.max_number_of_vc_wr_rsp_credit[port_id][vc_num] - upli_wr_rsp_channel_credit_vc[port_id][vc_num]) > (2**cfg.wr_rsp_credit_port_num_width)) begin
                wr_rsp_credit_num[port_id] = 2**cfg.wr_rsp_credit_port_num_width;
                upli_wr_rsp_channel_credit_vc[port_id][vc_num] += 2**cfg.wr_rsp_credit_port_num_width;
              end
              else begin
                wr_rsp_credit_num[port_id] = cfg.max_number_of_vc_wr_rsp_credit[port_id][vc_num] - upli_wr_rsp_channel_credit_vc[port_id][vc_num];
                upli_wr_rsp_channel_credit_vc[port_id][vc_num] += cfg.max_number_of_vc_wr_rsp_credit[port_id][vc_num] - upli_wr_rsp_channel_credit_vc[port_id][vc_num];
                credit_init_done_vc[port_id][vc_num] = 1;
              end
              wr_rsp_credit_vld[port_id] = 1;
              break;
            end
          end
        end
      end

      `ORIG_DRV_CB.wr_rsp_credit_pool          <= wr_rsp_pool_or_vc_credit_to_send;
      `ORIG_DRV_CB.wr_rsp_credit_port0_vc      <= wr_rsp_credit_vc[0];
      `ORIG_DRV_CB.wr_rsp_credit_port0_num     <= wr_rsp_credit_vc[0];
      if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
        `ORIG_DRV_CB.wr_rsp_credit_port1_vc    <= wr_rsp_credit_vc[1];
        `ORIG_DRV_CB.wr_rsp_credit_port1_num   <= wr_rsp_credit_vc[1];
        if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
          `ORIG_DRV_CB.wr_rsp_credit_port2_vc  <= wr_rsp_credit_vc[2];
          `ORIG_DRV_CB.wr_rsp_credit_port2_num <= wr_rsp_credit_vc[2];
          `ORIG_DRV_CB.wr_rsp_credit_port3_vc  <= wr_rsp_credit_vc[3];
          `ORIG_DRV_CB.wr_rsp_credit_port3_num <= wr_rsp_credit_vc[3];
        end
      end
      `ORIG_DRV_CB.wr_rsp_credit_vld    <= wr_rsp_credit_vld;
      @(`ORIG_DRV_CB);
      `ORIG_DRV_CB.wr_rsp_credit_vld    <= 0;
      wr_rsp_credit_vld                 = 0;
      wr_rsp_pool_or_vc_credit_to_send  = 0;

      for (int port_id = 0; port_id < 2**cfg.req_port_id_width; port_id++) begin
        if ((credit_init_done_pool[port_id] == 1) && ($countones(credit_init_done_vc[port_id]) == cfg.num_of_vc)) begin
          upli_wr_rsp_channel_credit_init_done[port_id] = 1;
        end
        else begin
          upli_wr_rsp_channel_credit_init_done[port_id] = 0;
        end
      end

      `ORIG_DRV_CB.wr_rsp_credit_init_done <= upli_wr_rsp_channel_credit_init_done;

    end
    // Send credit as per packet received in TLM port.
    else begin
      if (upli_wr_rsp_credit_q.size() > 0) begin
        xact = upli_wr_rsp_credit_q.pop_front();
        if (xact.wr_rsp_credit_vld > 0) begin
          `ORIG_DRV_CB.wr_rsp_credit_pool          <= xact.wr_rsp_credit_pool;
          `ORIG_DRV_CB.wr_rsp_credit_port0_vc      <= xact.wr_rsp_credit_port0_vc;
          `ORIG_DRV_CB.wr_rsp_credit_port0_num     <= xact.wr_rsp_credit_port0_num;
          if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
            `ORIG_DRV_CB.wr_rsp_credit_port1_vc    <= xact.wr_rsp_credit_port1_vc;
            `ORIG_DRV_CB.wr_rsp_credit_port1_num   <= xact.wr_rsp_credit_port1_num;
            if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
              `ORIG_DRV_CB.wr_rsp_credit_port2_vc  <= xact.wr_rsp_credit_port2_vc;
              `ORIG_DRV_CB.wr_rsp_credit_port2_num <= xact.wr_rsp_credit_port2_num;
              `ORIG_DRV_CB.wr_rsp_credit_port3_vc  <= xact.wr_rsp_credit_port3_vc;
              `ORIG_DRV_CB.wr_rsp_credit_port3_num <= xact.wr_rsp_credit_port3_num;
            end
          end
          `ORIG_DRV_CB.wr_rsp_credit_vld    <= xact.wr_rsp_credit_vld;
        end
        `ORIG_DRV_CB.wr_rsp_credit_init_done    <= xact.wr_rsp_credit_vld;
        @(`ORIG_DRV_CB);
        `ORIG_DRV_CB.wr_rsp_credit_vld    <= 0;
      end
      else begin
        @(`ORIG_DRV_CB);
      end
    end

  end

endtask: drive_wr_rsp_credits

// ==================================================================
task ualink_upli_orignator_active_common::drive_rd_rsp_credits();

  bit [`UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH-1:0] rd_rsp_pool_or_vc_credit_to_send;
  bit [`UPLI_MAX_RD_RSP_CREDIT_POOL_WIDTH-1:0] rd_rsp_credit_vld;
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT0_NUM_WIDTH-1:0] rd_rsp_credit_num[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH-1:0] rd_rsp_credit_vc[(2**`UPLI_MAX_REQ_VC_WIDTH)-1:0];
  bit credit_init_done_pool[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];
  bit [`UPLI_MAX_RD_RSP_CREDIT_PORT0_VC_WIDTH-1:0] credit_init_done_vc[(2**`UPLI_MAX_REQ_PORT_ID_WIDTH)-1:0];

  forever begin

    if (cfg.send_credit_auto) begin
      for (int port_id = 0; port_id < 2**cfg.req_port_id_width; port_id++) begin
        // Send pool credit first
        if(cfg.max_number_of_pool_rd_rsp_credit[port_id] > upli_rd_rsp_channel_credit_pool[port_id]) begin
          rd_rsp_pool_or_vc_credit_to_send[port_id] = 1;
          if ( (cfg.max_number_of_pool_rd_rsp_credit[port_id] - upli_rd_rsp_channel_credit_pool[port_id]) > (2**cfg.rd_rsp_credit_port_num_width)) begin
            rd_rsp_credit_num[port_id] = 2**cfg.rd_rsp_credit_port_num_width;
            upli_rd_rsp_channel_credit_pool[port_id] += 2**cfg.rd_rsp_credit_port_num_width;
          end
          else begin
            rd_rsp_credit_num[port_id] = cfg.max_number_of_pool_rd_rsp_credit[port_id] - upli_rd_rsp_channel_credit_pool[port_id];
            upli_rd_rsp_channel_credit_pool[port_id] += cfg.max_number_of_pool_rd_rsp_credit[port_id] - upli_rd_rsp_channel_credit_pool[port_id];
            credit_init_done_pool[port_id] = 1;
          end
          rd_rsp_credit_vld[port_id] = 1;
        end
        else begin
          // Send VC credit per port
          for (int vc_num = 0; vc_num < (2**cfg.req_vc_width); vc_num++) begin
            if(cfg.max_number_of_vc_rd_rsp_credit[port_id][vc_num] > upli_rd_rsp_channel_credit_vc[port_id][vc_num]) begin
              rd_rsp_pool_or_vc_credit_to_send[port_id] = 0;
              rd_rsp_credit_vc[port_id] = vc_num;
              if ( (cfg.max_number_of_vc_rd_rsp_credit[port_id][vc_num] - upli_rd_rsp_channel_credit_vc[port_id][vc_num]) > (2**cfg.rd_rsp_credit_port_num_width)) begin
                rd_rsp_credit_num[port_id] = 2**cfg.rd_rsp_credit_port_num_width;
                upli_rd_rsp_channel_credit_vc[port_id][vc_num] += 2**cfg.rd_rsp_credit_port_num_width;
              end
              else begin
                rd_rsp_credit_num[port_id] = cfg.max_number_of_vc_rd_rsp_credit[port_id][vc_num] - upli_rd_rsp_channel_credit_vc[port_id][vc_num];
                upli_rd_rsp_channel_credit_vc[port_id][vc_num] += cfg.max_number_of_vc_rd_rsp_credit[port_id][vc_num] - upli_rd_rsp_channel_credit_vc[port_id][vc_num];
                credit_init_done_vc[port_id][vc_num] = 1;
              end
              rd_rsp_credit_vld[port_id] = 1;
              break;
            end
          end
        end
      end

      `ORIG_DRV_CB.rd_rsp_credit_pool          <= rd_rsp_pool_or_vc_credit_to_send;
      `ORIG_DRV_CB.rd_rsp_credit_port0_vc      <= rd_rsp_credit_vc[0];
      `ORIG_DRV_CB.rd_rsp_credit_port0_num     <= rd_rsp_credit_vc[0];
      if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
        `ORIG_DRV_CB.rd_rsp_credit_port1_vc    <= rd_rsp_credit_vc[1];
        `ORIG_DRV_CB.rd_rsp_credit_port1_num   <= rd_rsp_credit_vc[1];
        if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
          `ORIG_DRV_CB.rd_rsp_credit_port2_vc  <= rd_rsp_credit_vc[2];
          `ORIG_DRV_CB.rd_rsp_credit_port2_num <= rd_rsp_credit_vc[2];
          `ORIG_DRV_CB.rd_rsp_credit_port3_vc  <= rd_rsp_credit_vc[3];
          `ORIG_DRV_CB.rd_rsp_credit_port3_num <= rd_rsp_credit_vc[3];
        end
      end
      `ORIG_DRV_CB.rd_rsp_credit_vld    <= rd_rsp_credit_vld;
      @(`ORIG_DRV_CB);
      `ORIG_DRV_CB.rd_rsp_credit_vld    <= 0;
      rd_rsp_credit_vld                 = 0;
      rd_rsp_pool_or_vc_credit_to_send  = 0;

      for (int port_id = 0; port_id < 2**cfg.req_port_id_width; port_id++) begin
        if ((credit_init_done_pool[port_id] == 1) && ($countones(credit_init_done_vc[port_id]) == cfg.num_of_vc)) begin
          upli_rd_rsp_channel_credit_init_done[port_id] = 1;
        end
        else begin
          upli_rd_rsp_channel_credit_init_done[port_id] = 0;
        end
      end

      `ORIG_DRV_CB.rd_rsp_credit_init_done <= upli_rd_rsp_channel_credit_init_done;

    end
    // Send credit as per packet received in TLM port.
    else begin
      if (upli_rd_rsp_credit_q.size() > 0) begin
        xact = upli_rd_rsp_credit_q.pop_front();
        if (xact.rd_rsp_credit_vld > 0) begin
          `ORIG_DRV_CB.rd_rsp_credit_pool          <= xact.rd_rsp_credit_pool;
          `ORIG_DRV_CB.rd_rsp_credit_port0_vc      <= xact.rd_rsp_credit_port0_vc;
          `ORIG_DRV_CB.rd_rsp_credit_port0_num     <= xact.rd_rsp_credit_port0_num;
          if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
            `ORIG_DRV_CB.rd_rsp_credit_port1_vc    <= xact.rd_rsp_credit_port1_vc;
            `ORIG_DRV_CB.rd_rsp_credit_port1_num   <= xact.rd_rsp_credit_port1_num;
            if (cfg.bifurgation_mode inside {UPLI_BIF_X2_2, UPLI_BIF_X1_4}) begin
              `ORIG_DRV_CB.rd_rsp_credit_port2_vc  <= xact.rd_rsp_credit_port2_vc;
              `ORIG_DRV_CB.rd_rsp_credit_port2_num <= xact.rd_rsp_credit_port2_num;
              `ORIG_DRV_CB.rd_rsp_credit_port3_vc  <= xact.rd_rsp_credit_port3_vc;
              `ORIG_DRV_CB.rd_rsp_credit_port3_num <= xact.rd_rsp_credit_port3_num;
            end
          end
          `ORIG_DRV_CB.rd_rsp_credit_vld    <= xact.rd_rsp_credit_vld;
        end
        `ORIG_DRV_CB.rd_rsp_credit_init_done    <= xact.rd_rsp_credit_vld;
        @(`ORIG_DRV_CB);
        `ORIG_DRV_CB.rd_rsp_credit_vld    <= 0;
      end
      else begin
        @(`ORIG_DRV_CB);
      end
    end

  end

endtask: drive_rd_rsp_credits

// ==================================================================
function bit ualink_upli_orignator_active_common::check_credit_to_send_req(ualink_upli_orignator_transaction xact);

  // read request only need request channel credit
  if(xact.is_read_cmd()) begin
    // If request use pool credit then check pool credits
    if(xact.is_req_pool()) begin
      if(upli_req_channel_credit_pool[xact.req_port_id] > 0) begin
        upli_req_channel_credit_pool[xact.req_port_id]--;
        return 1;
      end
    end
    // Check credit for requesting VC
    else begin
      if (upli_req_channel_credit_vc[xact.req_port_id][xact.req_vc] > 0) begin
        upli_req_channel_credit_vc[xact.req_port_id][xact.req_vc]--;
        return 1;
      end
    end
  // Write and Atomic request require request channel and orignator data channel credits
  end else begin
    // If request use pool credit then check pool credits
    if(xact.is_req_pool()) begin
      if((upli_req_channel_credit_pool[xact.req_port_id] > 0) &&
      (upli_orig_data_channel_credit_pool[xact.req_port_id] >= (xact.req_num_beats + 1))) begin
        upli_req_channel_credit_pool[xact.req_port_id]--;
        upli_orig_data_channel_credit_pool[xact.req_port_id] -= (xact.req_num_beats + 1);
        return 1;
      end
    end
    // Check credit for requesting VC
    else begin
      if ((upli_req_channel_credit_vc[xact.req_port_id][xact.req_vc] > 0 ) &&
      (upli_orig_data_channel_credit_vc[xact.req_port_id][xact.req_vc] >= (xact.req_num_beats + 1))) begin
        upli_req_channel_credit_vc[xact.req_port_id][xact.req_vc]--;
        upli_orig_data_channel_credit_vc[xact.req_port_id][xact.req_vc] -= (xact.req_num_beats + 1);
        return 1;
      end
    end
  end

  // Return 0 to indicate no suffecient credit to drive this transaction.
  return 0;

endfunction: check_credit_to_send_req

`endif // UALINK_UPLI_ORIGNATOR_ACTIVE_COMMON_SV
