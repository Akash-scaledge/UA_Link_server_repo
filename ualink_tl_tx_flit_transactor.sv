//------------------------------------------------------------------------------
// TL TX FLIT Transactor
// Receives ualink_upli_transaction from TL_TX_AGENT/monitor (via uvm_tlm_analysis_fifo)
// Builds control + data payload, packs into 64B flits 
// Sends each 64B flit out to DLL via flit_ap 
//------------------------------------------------------------------------------
`ifndef UALINK_TL_TX_FLIT_TRANSACTOR_SV 
`define UALINK_TL_TX_FLIT_TRANSACTOR_SV
 
 class ualink_tl_tx_flit_transactor extends uvm_component;

  `uvm_component_utils(ualink_tl_tx_flit_transactor)

  // Incoming UPLI→TL transactions
  uvm_tlm_analysis_fifo #(ualink_upli_transaction) upli_fifo;

  // Outgoing packed TL flits
  uvm_analysis_port #(ualink_tl_transaction) flit_ap;

   function new(string name = "ualink_tl_tx_flit_transactor", uvm_component parent = null);
    super.new(name, parent);
    upli_fifo = new("upli_fifo", this);
    flit_ap   = new("flit_ap",   this);
  endfunction

  //----------------------------------------------------------------------------
  // Run phase:
  //----------------------------------------------------------------------------
  task run_phase(uvm_phase phase);
    ualink_upli_transaction txn;

    forever begin
      upli_fifo.get(txn);         // blocks until monitor writes
      process_transaction(txn);    
    end
  endtask


  //----------------------------------------------------------------------------
  // Top-level processing
  //----------------------------------------------------------------------------
  function void process_transaction(ualink_upli_transaction txn);

    logic [511:0] flits[];
    // 1. Build control flit (uncompressed_req)
    ualink_tl_transaction ctrl_flit = build_control_flit(txn);

    // 2. Build data payload as dynamic array of 64B flits
    logic [511:0] data_64B[];
    build_data_payload(txn, data_64B);

    // 3. Insert control into first 64B flit and get final flit array
    concat_ctrl_and_data(ctrl_flit, data_64B, flits);

    // 4. Send each 64B flit out as a ualink_tl_transaction
    foreach (flits[i]) begin
      ualink_tl_transaction out = ualink_tl_transaction::type_id::create($sformatf("flit_%0d", i));
      out.data_64B[i] = flits[i];

   //   if (i == 0)
   //     out.tl_half_flit_type = tl_ctrl_flit;   // first flit carries control
   //   else
   //     out.tl_half_flit_type = tl_data_flit;   // subsequent flits are data

      flit_ap.write(out);
    end

  endfunction


  //----------------------------------------------------------------------------
  // 1. CONTROL FLIT BUILDER
    // 1. check for  ReqCmd[5:4]: 00=Read, 10=Write, 11=Atomic
    // 2. check for CLOAD/CWAY values.
    // 3. TX addr cache for compressed req/resp.

  //----------------------------------------------------------------------------
  function ualink_tl_transaction build_control_flit(ualink_upli_transaction txn);
    
    logic [5:0] cmd = txn.req_cmd;
    tl_upli_req_cmd_e tl_req_cmd;
    bit read_write;

    ualink_tl_transaction ctrl;
    ctrl = ualink_tl_transaction::type_id::create("ctrl");
    
    
    //////////////////////////////////////////////////
     //Request command when received: 
    ////////////////////////////////////////////////// 
    unique case (txn.req_cmd)
      TL_RD:          tl_req_cmd = TL_RD;
      TL_WR:          tl_req_cmd = TL_WR;
      TL_WR_FULL:     tl_req_cmd = TL_WR_FULL;
      TL_UPLI_WR_MSG: tl_req_cmd = TL_UPLI_WR_MSG;
      TL_ATOMIC_R:    tl_req_cmd = TL_ATOMIC_R;
      TL_ATOMIC_NR:   tl_req_cmd = TL_ATOMIC_NR;

      default: begin
        $error("Unknown TL opcode: %h", txn.req_cmd);
        tl_req_cmd = TL_RD; 
      end
    endcase

  if ( txn.req_vld ) begin // Indicates UPLI req command is received. 

    case (cmd[5:4])

        2'b00, 2'b10, 2'b11: begin
        ctrl.tl_req_cmd           = tl_req_cmd;
        ctrl.tl_half_flit_type    = tl_control_flit;
        ctrl.tl_req_resp_type     = uncompressed_req;
        ctrl.uncomp_req.ftype     = 4'h1;
        ctrl.uncomp_req.cmd       = txn.req_cmd;
        ctrl.uncomp_req.vchan     = txn.req_vc;
        ctrl.uncomp_req.asi       = txn.req_asi;
        ctrl.uncomp_req.tag       = txn.req_tag;
        ctrl.uncomp_req.pool      = txn.req_pool;
        ctrl.uncomp_req.attr      = txn.req_attr;
        ctrl.uncomp_req.len       = txn.req_len;
        ctrl.uncomp_req.metadata  = txn.req_meta_data;
        ctrl.uncomp_req.addr      = txn.req_addr[56:2];
        ctrl.uncomp_req.srcaccid  = txn.req_src_phys_acc_id;
        ctrl.uncomp_req.dstaccid  = txn.req_dst_phys_acc_id;
        ctrl.uncomp_req.cload     = '0; 
        ctrl.uncomp_req.cway      = '0; 
        ctrl.uncomp_req.numbeats  = txn.req_num_beats;
      end
    endcase
    `uvm_info("TL_TX-TRANSACTOR",$sformatf("Assigned tl_half_flit_type = %s, tl_req_resp_type = %s (request)",ctrl.tl_half_flit_type.name(),
        ctrl.tl_req_resp_type.name()),UVM_LOW);
  end

 //////////////////////////////////////////////////
 //UPLI response command when received 
 //////////////////////////////////////////////////

  unique case (txn.req_cmd)
   'h03,'h30: read_write = 1'b0;
   'h28,'h32: read_write = 1'b1;
  default:
    read_write = 1'b1;   
  endcase



  if ( txn.wr_rsp_vld ) begin // Indicates UPLI WR response command is received.
         ctrl.tl_req_resp_type     = uncompressed_rsp;
         ctrl.tl_half_flit_type    = tl_control_flit;
         ctrl.uncomp_rsp.ftype     = 4'h1;
         ctrl.uncomp_rsp.vchan     = txn.wr_rsp_vc;
         ctrl.uncomp_rsp.tag       = txn.wr_rsp_tag;
         ctrl.uncomp_rsp.pool      = txn.wr_rsp_pool;
         ctrl.uncomp_rsp.len       = 'h0;               //FIXME
         ctrl.uncomp_rsp.offset    = 'h0;               //FIXME
         ctrl.uncomp_rsp.status    = txn.wr_rsp_status;
         ctrl.uncomp_rsp.rd_wr     = read_write;
         ctrl.uncomp_rsp.last      = 'h0;               //FIXME
         ctrl.uncomp_rsp.srcaccid  = txn.wr_rsp_src_phys_acc_id;
         ctrl.uncomp_rsp.dstaccid  = txn.wr_rsp_dst_phys_acc_id;
         ctrl.uncomp_rsp.spare     = 'h0;               //FIXME

  `uvm_info("TL_TX-TRANSACTOR",$sformatf("Assigned tl_half_flit_type = %s, tl_req_resp_type = %s (response)",ctrl.tl_half_flit_type.name(),ctrl.tl_req_resp_type.name()),UVM_LOW);

  end


////////////////////////////////////////////////////////////////////////////////////////////////////
// For phase 2 : Add compressed req and resp based on referring to tx_addr cache 
////////////////////////////////////////////////////////////////////////////////////////////////////



    return ctrl;

  endfunction


  //----------------------------------------------------------------------------
  // 2. DATA PAYLOAD BUILDER
  //    Build dynamic array of 64B flits, one per beat
  //----------------------------------------------------------------------------
function void build_data_payload(ualink_upli_transaction txn,
                                 output logic [511:0] data_64B[]); 

  int total_dwords,total_bytes,num_beats;

  // No valid request → no payload
  if (!txn.req_vld) begin
    data_64B = new[0];
    return;
  end

  // Compute total bytes from ReqLen (DW = 4 bytes)
  total_dwords = txn.req_len + 1;
  total_bytes  = total_dwords * 4;

  // Compute number of 64B beats from ReqNumBeats
  num_beats = txn.req_num_beats + 1;

  // Allocate output array
  data_64B = new[num_beats];

  // Pack each beat
  for (int i = 0; i < num_beats; i++) begin

    // If OrigDataVld is not asserted, zero-fill this beat
    if (!txn.orig_data_vld) begin
      data_64B[i] = '0;
      continue; 
    end

    // Initialize flit to zero
    data_64B[i] = '0;

    // Each beat is 64 bytes
    for (int j = 0; j < 64; j++) begin

      // Global byte index across entire payload
      int byte_idx = i * 64 + j;

      // Stop if beyond total payload size
      if (byte_idx >= total_bytes)
        continue;

      // Only copy if byte lane is enabled
      if (txn.orig_data_byte_en[j]) begin
        data_64B[i][j*8 +: 8] = txn.orig_data[i][j*8 +: 8];
      end
    end
  end

endfunction

  //----------------------------------------------------------------------------
  // 3) CONCAT CONTROL + DATA
  //    Insert uncompressed_req into first 64B flit (sectors 4–7)
  //----------------------------------------------------------------------------
function void concat_ctrl_and_data(ualink_tl_transaction ctrl,
                                   logic [511:0] data_64B_in[],
                                   output logic [511:0] flits[]);

  logic [127:0] ctrl_bits = ctrl.uncomp_req;

  int n = data_64B_in.size();
  flits = new[n];

  // Flit 0: control + first half of data0
  flits[0] = '0;
  flits[0][255:128] = ctrl_bits;              // sectors 4–7
  flits[0][511:256] = data_64B_in[0][255:0];  // sectors 8–15

  // Flit 1 onward: pack remaining halves
  for (int i = 1; i < n; i++) begin
    flits[i] = '0;
    flits[i][255:0]   = data_64B_in[i-1][511:256]; // upper half of previous
    flits[i][511:256] = data_64B_in[i][255:0];     // lower half of current
  end

endfunction
endclass 
`endif // UALINK_TL_TX_FLIT_TRANSACTOR_SV
