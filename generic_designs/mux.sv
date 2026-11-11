module mux #(
    parameter NUM_INPUTS = 2,                                                         // set as a default
              DIN_WIDTH = 32,                                                         // set as default
              SEL_WIDTH = (NUM_INPUTS > 1) ? $clog2(NUM_INPUTS) : 1                   // local parameter - has to be defined to ensure sel is ok

)(
    input  logic[DIN_WIDTH-1:0]                  din[NUM_INPUTS-1:0],                 // data_inputs
    input  logic[SEL_WIDTH-1:0]                  sel,                                 // select_inputs
    output logic[DIN_WIDTH-1:0]                  dout
);

assign dout = din[sel];

endmodule
