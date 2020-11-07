module RAM_512x16_5 (
    input [8:0] ram_addr,
    input [15:0] ram_wdata,
    output [15:0] ram_rdata,
    input ce,
    input clk,
    input we,
    input re);

    wire [15:0] ram_rdata0;
    wire [15:0] ram_rdata1;

    assign ram_rdata = ram_addr[8] ? ram_rdata1 : ram_rdata0;

    SB_RAM40_4K RAM_inst0(
        .RDATA(ram_rdata0),
        .RADDR({3'b000,ram_addr[7:0]}),
        .RCLK(clk),
        .RCLKE(re&ce),
        .RE(re&ce),
        .WDATA(ram_wdata),
        .WADDR({3'b000,ram_addr[7:0]}),
        .WCLK(clk),
        .WCLKE(we&ce),
        .WE(we&ce),
        .MASK(16'h0000));
    defparam RAM_inst0.READ_MODE =0;
    defparam RAM_inst0.WRITE_MODE =0;

    SB_RAM40_4K RAM_inst1(
        .RDATA(ram_rdata1),
        .RADDR({3'b000,ram_addr[7:0]}),
        .RCLK(clk),
        .RCLKE(re&ce),
        .RE(re&ce),
        .WDATA(ram_wdata),
        .WADDR({3'b000,ram_addr[7:0]}),
        .WCLK(clk),
        .WCLKE(we&ce),
        .WE(we&ce),
        .MASK(16'h0000));
    defparam RAM_inst0.READ_MODE =0;
    defparam RAM_inst0.WRITE_MODE =0;
    /*organ*/
    defparam RAM_inst0.INIT_0 = 256'h5607_5962_5CBF_6031_63CE_67AB_6BD7_705E_7540_7A73_7FE1_856C_8AEB_902D_9500_992F;
    defparam RAM_inst0.INIT_1 = 256'h3F60_3C89_3A2C_3871_3775_3748_37EA_3951_3B66_3E0B_411E_447C_4803_4B97_4F24_52A0;
    defparam RAM_inst0.INIT_2 = 256'h3FB5_3FEA_413F_435D_45ED_4897_4B0B_4D05_4E51_4ECD_4E6B_4D32_4B38_48A4_45A8_427E;
    defparam RAM_inst0.INIT_3 = 256'hE403_DA08_CE88_C1BE_B3F6_A589_96DA_8852_7A5A_6D53_6195_5767_4EFB_486E_43C4_40E9;
    defparam RAM_inst0.INIT_4 = 256'hE973_EABE_EC6B_EE78_F0D6_F36A_F60D_F890_FAB9_FC4A_FD03_FCA5_FAF5_F7C2_F2E9_EC54;
    defparam RAM_inst0.INIT_5 = 256'hB360_BCB6_C526_CC99_D300_D85A_DCAF_E010_E297_E465_E59D_E669_E6F1_E760_E7DA_E882;
    defparam RAM_inst0.INIT_6 = 256'h4A71_47E7_46A9_46E3_48B2_4C20_5125_57AD_5F91_689F_729C_7D46_8856_9387_9E97_A946;
    defparam RAM_inst0.INIT_7 = 256'h6481_681B_6B53_6DF7_6FD8_70CE_70BF_6F9D_6D6C_6A40_663E_6198_5C8F_576B_527C_4E0F;
    defparam RAM_inst0.INIT_8 = 256'h3EF5_4124_432F_4508_46AE_482D_4999_4B0A_4C9F_4E71_5097_5320_560F_595D_5CF6_60BA;
    defparam RAM_inst0.INIT_9 = 256'h8998_7C23_6F45_634D_5883_4F1E_4741_4101_3C5C_393F_3789_370B_378E_38D4_3AA1_3CBC;
    defparam RAM_inst0.INIT_A = 256'hD90C_DE79_E30C_E68B_E8BD_E972_E880_E5CD_E148_DAF3_D2E1_C934_BE1F_B1E6_A4D6_9748;
    defparam RAM_inst0.INIT_B = 256'h97DF_9835_98E2_9A02_9BAD_9DF3_A0E1_A47D_A8C4_ADAE_B32B_B924_BF79_C604_CC99_D303;
    defparam RAM_inst0.INIT_C = 256'h7127_75FC_7AEB_7FC8_846A_88AF_8C7B_8FB8_925E_946A_95E4_96DD_976B_97AB_97BC_97C2;
    defparam RAM_inst0.INIT_D = 256'h68A8_67C3_6680_64F7_6345_6193_6008_5ED1_5E14_5DF4_5E88_5FE1_6203_64E5_6875_6C97;
    defparam RAM_inst0.INIT_E = 256'h8EEC_866B_7ECB_7835_72C2_6E7A_6B55_693D_680D_6798_67AC_6812_6896_6908_6942_6927;
    defparam RAM_inst0.INIT_F = 256'hCB5F_D14C_D616_D98C_DB87_DBED_DAAF_D7CE_D357_CD6C_C639_BDF8_B4EE_AB66_A1B0_9819;

    defparam RAM_inst1.INIT_0 = 256'h5AAE_5F82_64A0_6A12_6FE5_7620_7CCB_83E7_8B6F_9359_9B90_A3FB_AC76_B4D7_BCEC_C481;
    defparam RAM_inst1.INIT_1 = 256'h3327_3262_322B_3283_3369_34D4_36BC_3914_3BCE_3EDD_4235_45CB_4996_4D92_51BD_561A;
    defparam RAM_inst1.INIT_2 = 256'h5380_5260_5144_500A_4E99_4CE1_4ADC_488C_45FC_433E_4068_3D94_3ADE_3860_3635_3471;
    defparam RAM_inst1.INIT_3 = 256'hCA90_BE65_B1EF_A584_9971_8DFE_8366_79D6_716D_6A39_6439_5F5F_5B8F_58A5_5674_54CD;
    defparam RAM_inst1.INIT_4 = 256'hD32C_DBB2_E3D9_EB67_F21F_F7C2_FC14_FEE2_FFFF_FF4C_FCBA_F848_F209_EA1F_E0BB_D61D;
    defparam RAM_inst1.INIT_5 = 256'h66FF_6B93_7075_759E_7B0A_80B7_86A7_8CDF_9366_9A43_A17C_A913_B105_B94A_C1D0_CA7D;
    defparam RAM_inst1.INIT_6 = 256'h57DD_5625_54A0_5355_524D_5193_5133_513A_51B3_52A5_5418_560F_5887_5B7D_5EEA_62C3;
    defparam RAM_inst1.INIT_7 = 256'h8A25_86A7_82EC_7F0E_7B22_773C_736D_6FC3_6C49_6904_65F6_6320_6080_5E13_5BD4_59C2;
    defparam RAM_inst1.INIT_8 = 256'h6DE4_7511_7BA5_818E_86BD_8B29_8EC9_919C_93A0_94D8_9548_94F9_93F6_924D_900F_8D4F;
    defparam RAM_inst1.INIT_9 = 256'h3272_2BA5_26BB_23C4_22BC_238F_261B_2A30_2F96_3610_3D5E_4542_4D7F_55DC_5E28_6637;
    defparam RAM_inst1.INIT_A = 256'hB4DE_B695_B695_B4B2_B0D3_AAFC_A345_99DD_8F08_831B_7677_6988_5CB8_5072_4517_3AFF;
    defparam RAM_inst1.INIT_B = 256'h97CB_936A_8F9E_8CA1_8AA5_89D1_8A3A_8BE4_8EC1_92AF_977B_9CE1_A28F_A82B_AD55_B1AE;
    defparam RAM_inst1.INIT_C = 256'h9288_9955_9F95_A523_A9DB_AD9F_B059_B1F7_B274_B1D2_B020_AD77_A9F9_A5D6_A143_9C7F;
    defparam RAM_inst1.INIT_D = 256'h4894_48B3_4954_4A8E_4C74_4F15_5279_56A1_5B86_611C_674F_6E05_751F_7C7B_83F1_8B59;
    defparam RAM_inst1.INIT_E = 256'h60B1_5CC6_597D_56CC_549F_52DE_516F_5039_4F25_4E22_4D23_4C25_4B2C_4A40_4974_48DD;
    defparam RAM_inst1.INIT_F = 256'h9C8A_9EE6_A022_A02A_9EF8_9C92_990E_948F_8F42_895B_8312_7CA2_7642_7022_6A6D_6540;

endmodule