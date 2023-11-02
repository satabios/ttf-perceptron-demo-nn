`default_nettype none

module tt_um_perceptron #( parameter MAX_COUNT = 24'd10_000_000 ) (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  

reg [7:0] X [1:0]; // [dimnension of data][no. of samples]
reg signed [7:0] W [1:0];

reg [7:0] partial_mac_out;
reg [7:0] z1;
reg [7:0] mac_out;
reg [7:0] activation_out;


initial begin

    W[0]= {4'd0,4'd4};
    W[1]= {4'd0,4'd9};

    W[0]= {4'd0,4'd4};
    W[1] = {4'd0,4'd9};

    X[0] = {4'd0,4'd2};
    X[1]= {4'd0,4'd3};
    partial_mac_out = 0;


end



always @(posedge clk)begin

    partial_mac_out = X[0] * W[0];
    z1 = partial_mac_out + (X[1] * W[1]);
    activation_out = z1 > 8'd0 ? z1 : 8'd0;



    // mac mac_instance
    // ( 
    // .x(X[0]),
    // .w(W[0]),
    // .previous_out(partial_mac_out),
    // .clk(clk),
    // .rst_n(rst_n), // reset_n - low to reset
    // .out(z1)
    // );

  
    // activation_out = mac_out > 8'd0 ? mac_out : 8'd0;
    $display("%b %b %b",partial_mac_out, z1, activation_out);

   

end
assign  uo_out = activation_out;


endmodule
