// look in pins.pcf for all the pin names on the TinyFPGA BX board
module top_atrain (
    input   CLK,    // 16MHz clock
    
    output  LED,    // User/boot LED next to power LED
    output  USBPU,  // USB pull-up resistor

    //debug I/O prots
    output OUT1, //Pin11 ->OUT
    output OUT2, //Pin6 ->OUT
    output OUT3, //PIin7 ->OUT
    output OUT4, //Pin8 ->OUT
    output OUT5, //Pin9 ->OUT
    output OUT6, //Pin10 ->OUT
    input   nRST,  // Pin12-> IN

    //PWM Signal Output
    output  PWM_OUT,  // Pin13-> OUT

);
    // drive USB pull-up resistor to '0' to disable USB comunication
    assign USBPU = 0;

    // set the on board LED continious on to indicate user program mode
    assign LED = 1;

    // parameter tone_A4 = 11'd567; //A4
    // parameter tone_B4 = 11'd505; //B4
    // parameter tone_C4 = 11'd477; //C4
    // parameter tone_D4 = 11'd425; //D4
    // parameter tone_E4 = 11'd378; //E4
    // parameter tone_F4 = 11'd357; //F4
    // parameter tone_G4 = 11'd318; //G4
    // parameter tone_A5 = 11'd283; //A5 

    parameter tone_F1  = 11'd1275; //F1
    parameter tone_F1S = 11'd1203; //F#1
    parameter tone_G1  = 11'd1035; //G1
    parameter tone_G1S = 11'd1072; //G#1
    parameter tone_A2  = 11'd1011; //A2
    parameter tone_B2  = 11'd955; //B2
    parameter tone_C2  = 11'd901; //C2
    parameter tone_C2S = 11'd850; //C#2    
    parameter tone_D2  = 11'd803; //D2
    parameter tone_D2S = 11'd757; //D#2    
    parameter tone_E2  = 11'd715; //E2

    parameter tone_F2  = 11'd675; //F2
    parameter tone_F2S = 11'd637; //F#2
    parameter tone_G2  = 11'd601; //G2
    parameter tone_G2S = 11'd567; //G#2
    parameter tone_A3  = 11'd535; //A3
    parameter tone_B3  = 11'd505; //B3
    parameter tone_C3  = 11'd477; //C3
    parameter tone_C3S = 11'd450; //C#3    
    parameter tone_D3  = 11'd425; //D3
    parameter tone_D3S = 11'd401; //D#3    
    parameter tone_E3  = 11'd378; //E3
    parameter tone_F3  = 11'd357; //F3
    parameter tone_F3S = 11'd337; //F#3
    parameter tone_G3  = 11'd318; //G3
    parameter tone_G3S = 11'd300; //G#3
    parameter tone_A4  = 11'd283; //A4
    parameter tone_A4S = 11'd267; //A#4
    parameter tone_B4  = 11'd252; //B4
    parameter tone_C4  = 11'd238; //C4
    parameter tone_C4S = 11'd224; //C#4    
    parameter tone_D4  = 11'd212; //D4
    parameter tone_D4S = 11'd200; //D#4    
    parameter tone_E4  = 11'd189; //E4
    parameter tone_F4  = 11'd178; //F4
    parameter tone_F4S = 11'd168; //F#4
    parameter tone_G4  = 11'd158; //G4
    parameter tone_G4S = 11'd149; //G#4
    parameter tone_A5  = 11'd141; //A5 
    parameter tone_A5S = 11'd133; //A#5 
    parameter tone_B5  = 11'd126; //B5 
    parameter tone_C5  = 11'd118; //C5
    parameter tone_C5S = 11'd112; //C#5
    parameter tone_D5  = 11'd105; //D5
    parameter tone_D5S = 11'd99; //D#5
    parameter tone_E5  = 11'd94; //E5
    parameter tone_F5  = 11'd88; //F5
    parameter tone_F5S = 11'd83; //F#5
    parameter tone_G5  = 11'd79; //G5   
    parameter tone_G5S = 11'd74; //GE5  
    parameter tone_A6  = 11'd70; //A6  


    reg [8:0] addr0 = 9'h000;
    //reg [8:0] addr1 = 9'h000;

    reg [15:0] wdata = 16'h0000;

    wire [15:0] rdata0 ;
    //wire [15:0] rdata1 ;

    wire clk64m;

    wire clk0;
    wire clk1;

    wire clk_low;
    wire clk_chk;

    wire [15:0] silent = 16'h7FFF;

    reg  OE0 = 1'b0;
    //reg  OE1 = 1'b0;

    wire  [15:0] data_out0 =  ((OE0 ? rdata0  : silent) );
    //wire  [15:0] data_out1 =  ((OE1 ? rdata1  : silent) )>>4; 
    // wire signed [15:0] data_out_sig = (data_out0>>5) + (data_out1>>6);
    // wire [15:0] data_out  =  data_out_sig  + silent;        

    reg [10:0] div_num0 = tone_A2;
    //reg [10:0] div_num1 = tone_A2;

    RAM_512x16_4 M0(
        .ram_addr(addr0),
        .ram_wdata(wdata),
        .ram_rdata(rdata0),
        .ce(1'b1),
        .clk(clk0),
        .we(1'b0),
        .re(1'b1));



    PLL64m U10( .REFERENCECLK(CLK),
                .PLLOUTCORE(clk64m),
                .PLLOUTGLOBAL(),
                .RESET(1'b1),
                .LOCK(OUT6));

    PWM_generator U0(
        .clk(clk64m_a),
        .d_in(data_out0[15:7]),
        //.d_in(11'h3ff),
        .pwm_out(OUT1));
    defparam U0.fclkm = 64000000;
    defparam U0.fs = 44100;
    defparam U0.res = 9;

    divider_variable D0(
        .clk(clk64m),
        .out(clk0),
        .div_num(div_num0));


    // divider D11(clk128m_b,clk_chk);
    // defparam D11.divide_num=63999999;
   
    divider D12(CLK,clk_low);
    defparam D12.divide_num=799999; //12Hz

    always @(negedge clk0)begin
        addr0 <= addr0 + 1;
    end


    reg [15:0] count = 16'd210;



    // Nuebo Cinema Paradiso tema D'amore lead part

    always @(posedge clk_low,negedge nRST)begin
        if(~nRST)begin
            count <= 16'd0;
            OE0 <= 1'b0;
            div_num0 <= tone_C4;
        end
        else if(count != 16'd210) begin
            count <= count +1;
            case(count)
                16'd1   : {OE0,div_num0} <= {1'b1,tone_G3};
                16'd7   : {OE0,div_num0} <= {1'b1,tone_E4};              
                16'd10  : {OE0,div_num0} <= {1'b1,tone_D4};  
                16'd13  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd16  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd17  : {OE0,div_num0} <= {1'b1,tone_C4};  
                16'd18  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd19  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd21  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd22  : {OE0,div_num0} <= {1'b1,tone_C4};
                
                16'd25  : {OE0,div_num0} <= {1'b1,tone_D4};
                16'd29  : {OE0,div_num0} <= {1'b1,tone_C4};  
                16'd31  : {OE0,div_num0} <= {1'b1,tone_A4}; 
                16'd34  : {OE0,div_num0} <= {1'b1,tone_C4};   
                16'd37  : {OE0,div_num0} <= {1'b1,tone_G3};  
                16'd45  : {OE0,div_num0} <= {1'b0,tone_G3};  


                16'd49  : {OE0,div_num0} <= {1'b1,tone_G3};
                16'd55  : {OE0,div_num0} <= {1'b1,tone_E4};            
                16'd58  : {OE0,div_num0} <= {1'b1,tone_D4};  
                16'd61  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd64  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd65  : {OE0,div_num0} <= {1'b1,tone_C4};  
                16'd66  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd67  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd69  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd70  : {OE0,div_num0} <= {1'b1,tone_C4};

                16'd73  : {OE0,div_num0} <= {1'b1,tone_D4};
                16'd77  : {OE0,div_num0} <= {1'b1,tone_C4};  
                16'd79  : {OE0,div_num0} <= {1'b1,tone_A4};   
                16'd82  : {OE0,div_num0} <= {1'b1,tone_C4};    
                16'd85  : {OE0,div_num0} <= {1'b1,tone_G3}; 
                16'd93  : {OE0,div_num0} <= {1'b0,tone_G3}; 

                16'd97  : {OE0,div_num0} <= {1'b1,tone_G4}; 
                16'd109 : {OE0,div_num0} <= {1'b1,tone_E4}; 
                16'd118 : {OE0,div_num0} <= {1'b1,tone_G4}; 

                16'd121  : {OE0,div_num0} <= {1'b1,tone_E4}; 
                16'd127  : {OE0,div_num0} <= {1'b1,tone_D4};
                16'd130  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd132  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd133  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd138  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd139  : {OE0,div_num0} <= {1'b1,tone_C4};  
                16'd142  : {OE0,div_num0} <= {1'b0,tone_C4};  

                16'd145  : {OE0,div_num0} <= {1'b1,tone_E4}; 
                16'd154  : {OE0,div_num0} <= {1'b1,tone_G4}; 
                16'd157  : {OE0,div_num0} <= {1'b1,tone_D4}; 
                16'd166  : {OE0,div_num0} <= {1'b1,tone_E4};  

                16'd169  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd174  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd175  : {OE0,div_num0} <= {1'b1,tone_C4}; 
                16'd177  : {OE0,div_num0} <= {1'b0,tone_C4}; 
                16'd178  : {OE0,div_num0} <= {1'b1,tone_C4};
                16'd180  : {OE0,div_num0} <= {1'b0,tone_C4};  
                16'd181  : {OE0,div_num0} <= {1'b1,tone_C4}; 
                16'd185  : {OE0,div_num0} <= {1'b0,tone_C4}; 
    
            endcase
        end
    end 

 


    //assign OUT1=data_out0[15];
    assign OUT2=data_out0[14];
    assign OUT3=data_out0[13];
    assign OUT4=data_out0[12];
    //assign OUT5=rdata0[11];
    //assign OUT6=rdata[10];
    assign OUT5=nRST;

endmodule

