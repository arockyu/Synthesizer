`timescale 1ns/1ps

module top_tb();

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0,U102,U201,U202,U301);
    end



     initial begin
        // ck = 1'b0;
        // rst = 1'b0;

        // wdata=8'h01;
        // data_cnt=8'h01;
        // sda_in= 1'b1;

        // tx_en =1'b0;
        // rx_en =1'b0;
        // sel =1'b0;
        // #20000  sel = 1'b1;
        // #6400   sel = 1'b0;

        // #6400   rx_en = 1'b1;
        // #5000   rx_en = 1'b0;
        
        // #52600  rx_en = 1'b1;
        // #5000   rx_en = 1'b0;
    
        // #52000 wdata=8'hc3;
        // #600   rx_en = 1'b1;
        // #5000   rx_en = 1'b0;
        
        #200000 $finish;
    end



endmodule