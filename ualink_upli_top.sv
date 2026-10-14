


module upli_top;

//   import uvm_pkg::*;
//   import ualink_upli_env_pkg::*;

  // --------------------------------------------------------------------------
  // Clock / Reset
  // --------------------------------------------------------------------------
  logic upli_clk;
  logic upli_resetn;

  // --------------------------------------------------------------------------
  // Clock Timing Variables
  // --------------------------------------------------------------------------
  time upli_clk_period;
  time upli_clk_half_period;

  // --------------------------------------------------------------------------
  // Reset Timing Variable
  // --------------------------------------------------------------------------
  time upli_reset_deassert_delay;

  // --------------------------------------------------------------------------
  // Clock Generation
  // --------------------------------------------------------------------------
  initial begin
    upli_clk_period      = 10ns;   // 100 MHz
    upli_clk_half_period = upli_clk_period / 2;

    upli_clk = 1'b0;
    forever #upli_clk_half_period upli_clk = ~upli_clk;
  end

  // --------------------------------------------------------------------------
  // Reset Generation (active-low)
  // --------------------------------------------------------------------------
  initial begin
    // Reset asserted immediately at time 0
    upli_resetn = 1'b0;

    // Configure deassert delay here
    upli_reset_deassert_delay = 100ns;

    // Hold reset low, then deassert
    #upli_reset_deassert_delay;
    upli_resetn = 1'b1;
  end

  // --------------------------------------------------------------------------
  // UPLI Interface
  // --------------------------------------------------------------------------
  ualink_upli_interface upli_if (
    .upli_clk    (upli_clk),
    .upli_resetn (upli_resetn)
  );

  // --------------------------------------------------------------------------
  // HDL Wrapper
  // --------------------------------------------------------------------------
  upli_hdl_wrapper u_upli_hdl_wrapper (
    .upli_if     (upli_if)
  );

  // --------------------------------------------------------------------------
  // UVM Config DB
  // --------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual ualink_upli_interface)::set(
      null,
      "*",
      "upli_vif",
      upli_if
    );
    
    
  end

  // --------------------------------------------------------------------------
  // Waveform Dump Control
  // --------------------------------------------------------------------------
  initial begin

    `ifdef DUMP_VCD
    $dumpfile("upli.vcd");
    $dumpvars(0, upli_top);
    `endif

    `ifdef DUMP_FSDB
    $fsdbDumpfile("upli.fsdb");
    $fsdbDumpvars(0, upli_top);
    $fsdbDumpMDA();
    $fsdbDumpSVA();
    `endif

  end

  // --------------------------------------------------------------------------
  // run_test
  // --------------------------------------------------------------------------
  initial begin
    run_test("ualink_upli_base_test");
  end

endmodule
