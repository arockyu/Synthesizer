module PLL128m(REFERENCECLK,
               PLLOUTCOREA,
               PLLOUTCOREB,
               PLLOUTGLOBALA,
               PLLOUTGLOBALB,
               RESET,
               LOCK);

input REFERENCECLK;
input RESET;    /* To initialize the simulation properly, the RESET signal (Active Low) must be asserted at the beginning of the simulation */ 
output PLLOUTCOREA;
output PLLOUTCOREB;
output PLLOUTGLOBALA;
output PLLOUTGLOBALB;
output LOCK;

SB_PLL40_2F_CORE PLL128m_inst(.REFERENCECLK(REFERENCECLK),
                              .PLLOUTCOREA(PLLOUTCOREA),
                              .PLLOUTCOREB(PLLOUTCOREB),
                              .PLLOUTGLOBALA(PLLOUTGLOBALA),
                              .PLLOUTGLOBALB(PLLOUTGLOBALB),
                              .EXTFEEDBACK(),
                              .DYNAMICDELAY(),
                              .RESETB(RESET),
                              .BYPASS(1'b0),
                              .LATCHINPUTVALUE(),
                              .LOCK(LOCK),
                              .SDI(),
                              .SDO(),
                              .SCLK());

//\\ Fin=16, Fout=128;
defparam PLL128m_inst.DIVR = 4'b0000;
defparam PLL128m_inst.DIVF = 7'b0000111;
defparam PLL128m_inst.DIVQ = 3'b001;
defparam PLL128m_inst.FILTER_RANGE = 3'b001;
defparam PLL128m_inst.FEEDBACK_PATH = "PHASE_AND_DELAY";
defparam PLL128m_inst.DELAY_ADJUSTMENT_MODE_FEEDBACK = "FIXED";
defparam PLL128m_inst.FDA_FEEDBACK = 4'b0000;
defparam PLL128m_inst.DELAY_ADJUSTMENT_MODE_RELATIVE = "FIXED";
defparam PLL128m_inst.FDA_RELATIVE = 4'b0000;
defparam PLL128m_inst.SHIFTREG_DIV_MODE = 2'b00;
defparam PLL128m_inst.PLLOUT_SELECT_PORTA = "SHIFTREG_0deg";
defparam PLL128m_inst.PLLOUT_SELECT_PORTB = "SHIFTREG_90deg";
defparam PLL128m_inst.ENABLE_ICEGATE_PORTA = 1'b0;
defparam PLL128m_inst.ENABLE_ICEGATE_PORTB = 1'b0;

endmodule
