module tb_fifo;
reg clk, rst, wr_en, rd_en;
reg [7:0] din;
wire [7:0] dout;
wire full, empty;

fifo uut (.clk(clk),.rst(rst),.wr_en(wr_en),
    .rd_en(rd_en),.din(din),.dout(dout),
    .full(full),.empty(empty));

always #5 clk = ~clk;

initial begin
    $dumpfile("fifo.vcd");
    $dumpvars(0, tb_fifo);
    clk=0; rst=1; wr_en=0; rd_en=0; din=0;
    #20 rst=0;
    
    // Write data
    wr_en=1;
    din=8'hAA; #10;
    din=8'hBB; #10;
    din=8'hCC; #10;
    din=8'hDD; #10;
    wr_en=0;
    
    // Read data
    #10 rd_en=1;
    #10; #10; #10; #10;
    rd_en=0;
    
    #20;
    $display("Full: %b, Empty: %b", full, empty);
    $display("Last dout: %h", dout);
    $finish;
end
endmodule