`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/07/10 14:59:10
// Design Name: 
// Module Name: data_delay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module data_delay (
  clk           ,
  reset_n       ,
  data_in       ,
  data_delay_out,
  delay_clk_num 
  );
  parameter data_width =8;
  input        clk           ;
  input        reset_n       ;
  input  [data_width-1:0] data_in       ;
  input  [7:0] delay_clk_num ;
  output [data_width-1:0] data_delay_out;
  
  // Internal register.
  reg  [data_width-1:0] data_delay_out;
  reg  [data_width-1:0] data_in_0 ;
  reg  [data_width-1:0] data_in_1 ;
  reg  [data_width-1:0] data_in_2 ;
  reg  [data_width-1:0] data_in_3 ;
  reg  [data_width-1:0] data_in_4 ;
  reg  [data_width-1:0] data_in_5 ;
  reg  [data_width-1:0] data_in_6 ;
  reg  [data_width-1:0] data_in_7 ;
  reg  [data_width-1:0] data_in_8 ;
  reg  [data_width-1:0] data_in_9 ;
  reg  [data_width-1:0] data_in_10;
  reg  [data_width-1:0] data_in_11;
  reg  [data_width-1:0] data_in_12;
  reg  [data_width-1:0] data_in_13;
  reg  [data_width-1:0] data_in_14;
  reg  [data_width-1:0] data_in_15;
  reg  [data_width-1:0] data_in_16;
  reg  [data_width-1:0] data_in_17;
  reg  [data_width-1:0] data_in_18;
  reg  [data_width-1:0] data_in_19;
  reg  [data_width-1:0] data_in_20;
  reg  [data_width-1:0] data_in_21;
  reg  [data_width-1:0] data_in_22;
  reg  [data_width-1:0] data_in_23;
  reg  [data_width-1:0] data_in_24;
  reg  [data_width-1:0] data_in_25;
  reg  [data_width-1:0] data_in_26;
  reg  [data_width-1:0] data_in_27;
  reg  [data_width-1:0] data_in_28;
  reg  [data_width-1:0] data_in_29;
  reg  [data_width-1:0] data_in_30;
  reg  [data_width-1:0] data_in_31;
  reg  [data_width-1:0] data_in_32;
  reg  [data_width-1:0] data_in_33;
  reg  [data_width-1:0] data_in_34;
  reg  [data_width-1:0] data_in_35;
  reg  [data_width-1:0] data_in_36;
  reg  [data_width-1:0] data_in_37;
  reg  [data_width-1:0] data_in_38;
  reg  [data_width-1:0] data_in_39;
  reg  [data_width-1:0] data_in_40;
  reg  [data_width-1:0] data_in_41;
  reg  [data_width-1:0] data_in_42;
  reg  [data_width-1:0] data_in_43;
  reg  [data_width-1:0] data_in_44;
  reg  [data_width-1:0] data_in_45;
  reg  [data_width-1:0] data_in_46;
  reg  [data_width-1:0] data_in_47;
  reg  [data_width-1:0] data_in_48;
  reg  [data_width-1:0] data_in_49;
  reg  [data_width-1:0] data_in_50;
  reg  [data_width-1:0] data_in_51; 
  reg  [data_width-1:0] data_in_52; 
  reg  [data_width-1:0] data_in_53; 
  reg  [data_width-1:0] data_in_54; 
  reg  [data_width-1:0] data_in_55; 
  reg  [data_width-1:0] data_in_56; 
  reg  [data_width-1:0] data_in_57; 
  reg  [data_width-1:0] data_in_58; 
  reg  [data_width-1:0] data_in_59; 
  reg  [data_width-1:0] data_in_60; 
  reg  [data_width-1:0] data_in_61; 
  reg  [data_width-1:0] data_in_62; 
  reg  [data_width-1:0] data_in_63; 
  reg  [data_width-1:0] data_in_64; 
  reg  [data_width-1:0] data_in_65; 
  reg  [data_width-1:0] data_in_66; 
  reg  [data_width-1:0] data_in_67; 
  reg  [data_width-1:0] data_in_68; 
  reg  [data_width-1:0] data_in_69; 
  reg  [data_width-1:0] data_in_70; 
  reg  [data_width-1:0] data_in_71; 
  reg  [data_width-1:0] data_in_72; 
  reg  [data_width-1:0] data_in_73; 
  reg  [data_width-1:0] data_in_74; 
  reg  [data_width-1:0] data_in_75; 
  reg  [data_width-1:0] data_in_76; 
  reg  [data_width-1:0] data_in_77; 
  reg  [data_width-1:0] data_in_78; 
  reg  [data_width-1:0] data_in_79; 
  reg  [data_width-1:0] data_in_80; 
  reg  [data_width-1:0] data_in_81; 
  reg  [data_width-1:0] data_in_82; 
  reg  [data_width-1:0] data_in_83; 
  reg  [data_width-1:0] data_in_84; 
  reg  [data_width-1:0] data_in_85; 
  reg  [data_width-1:0] data_in_86; 
  reg  [data_width-1:0] data_in_87; 
  reg  [data_width-1:0] data_in_88; 
  reg  [data_width-1:0] data_in_89; 
  reg  [data_width-1:0] data_in_90;
  reg  [data_width-1:0] data_in_91; 
  reg  [data_width-1:0] data_in_92; 
  reg  [data_width-1:0] data_in_93; 
  reg  [data_width-1:0] data_in_94; 
  reg  [data_width-1:0] data_in_95; 
  reg  [data_width-1:0] data_in_96; 
  reg  [data_width-1:0] data_in_97; 
  reg  [data_width-1:0] data_in_98; 
  reg  [data_width-1:0] data_in_99; 
  reg  [data_width-1:0] data_in_100; 
  reg  [data_width-1:0] data_in_101; 
  reg  [data_width-1:0] data_in_102; 
  reg  [data_width-1:0] data_in_103; 
  reg  [data_width-1:0] data_in_104; 
  reg  [data_width-1:0] data_in_105; 
  reg  [data_width-1:0] data_in_106; 
  reg  [data_width-1:0] data_in_107; 
  reg  [data_width-1:0] data_in_108; 
  reg  [data_width-1:0] data_in_109; 
  reg  [data_width-1:0] data_in_110;
  reg  [data_width-1:0] data_in_111; 
  reg  [data_width-1:0] data_in_112; 
  reg  [data_width-1:0] data_in_113; 
  reg  [data_width-1:0] data_in_114; 
  reg  [data_width-1:0] data_in_115; 
  reg  [data_width-1:0] data_in_116; 
  reg  [data_width-1:0] data_in_117; 
  reg  [data_width-1:0] data_in_118; 
  reg  [data_width-1:0] data_in_119; 
  reg  [data_width-1:0] data_in_120; 
  reg  [data_width-1:0] data_in_121; 
  reg  [data_width-1:0] data_in_122; 
  reg  [data_width-1:0] data_in_123; 
  reg  [data_width-1:0] data_in_124; 
  reg  [data_width-1:0] data_in_125; 
  reg  [data_width-1:0] data_in_126; 
  reg  [data_width-1:0] data_in_127; 
  reg  [data_width-1:0] data_in_128; 


  
  always @ (posedge clk or negedge reset_n) begin
    if(reset_n==1'b0) begin
      data_in_0  <= 8'b0; 
      data_in_1  <= 8'b0;
      data_in_2  <= 8'b0;
      data_in_3  <= 8'b0;
      data_in_4  <= 8'b0;
      data_in_5  <= 8'b0;
      data_in_6  <= 8'b0;
      data_in_7  <= 8'b0;
      data_in_8  <= 8'b0;
      data_in_9  <= 8'b0;
      data_in_10 <= 8'b0;
      data_in_11 <= 8'b0;
      data_in_12 <= 8'b0;
      data_in_13 <= 8'b0;
      data_in_14 <= 8'b0;
      data_in_15 <= 8'b0;
      data_in_16 <= 8'b0;
      data_in_17 <= 8'b0;
      data_in_18 <= 8'b0;
      data_in_19 <= 8'b0;
      data_in_20 <= 8'b0;
      data_in_21 <= 8'b0;
      data_in_22 <= 8'b0;
      data_in_23 <= 8'b0;
      data_in_24 <= 8'b0;
      data_in_25 <= 8'b0;
      data_in_26 <= 8'b0;
      data_in_27 <= 8'b0;
      data_in_28 <= 8'b0;
      data_in_29 <= 8'b0;
      data_in_30 <= 8'b0;
      data_in_31 <= 8'b0;
      data_in_32 <= 8'b0;
      data_in_33 <= 8'b0;
      data_in_34 <= 8'b0;
      data_in_35 <= 8'b0;
      data_in_36 <= 8'b0;
      data_in_37 <= 8'b0;
      data_in_38 <= 8'b0;
      data_in_39 <= 8'b0;
      data_in_40 <= 8'b0;
      data_in_41 <= 8'b0;
      data_in_42 <= 8'b0;
      data_in_43 <= 8'b0;
      data_in_44 <= 8'b0;
      data_in_45 <= 8'b0;
      data_in_46 <= 8'b0;
      data_in_47 <= 8'b0;
      data_in_48 <= 8'b0;
      data_in_49 <= 8'd0;   
      data_in_50 <= 8'd0;
      data_in_51 <= 8'd0;
      data_in_52 <= 8'd0;
      data_in_53 <= 8'd0;
      data_in_54 <= 8'd0;
      data_in_55 <= 8'd0;
      data_in_56 <= 8'd0;
      data_in_57 <= 8'd0;
      data_in_58 <= 8'd0;
      data_in_59 <= 8'd0;
      data_in_60 <= 8'd0;
      data_in_61 <= 8'd0;
      data_in_62 <= 8'd0;
      data_in_63 <= 8'd0;
      data_in_64 <= 8'd0;
      data_in_65 <= 8'd0;
      data_in_66 <= 8'd0;
      data_in_67 <= 8'd0;
      data_in_68 <= 8'd0;
      data_in_69 <= 8'd0;
      data_in_70 <= 8'd0;
      data_in_71 <= 8'b0;
      data_in_72 <= 8'b0;
      data_in_73 <= 8'b0;
      data_in_74 <= 8'b0;
      data_in_75 <= 8'b0;
      data_in_76 <= 8'b0;
      data_in_77 <= 8'b0;
      data_in_78 <= 8'b0;
      data_in_79 <= 8'b0;
      data_in_80 <= 8'b0;
      data_in_81 <= 8'b0;
      data_in_82 <= 8'b0;
      data_in_83 <= 8'b0;
      data_in_84 <= 8'b0;
      data_in_85 <= 8'b0;
      data_in_86 <= 8'b0;
      data_in_87 <= 8'b0;
      data_in_88 <= 8'b0;
      data_in_89 <= 8'b0;
      data_in_90 <= 8'b0;
      data_in_91 <= 8'b0;
      data_in_92 <= 8'b0;
      data_in_93 <= 8'b0;
      data_in_94 <= 8'b0;
      data_in_95 <= 8'b0;
      data_in_96 <= 8'b0;
      data_in_97 <= 8'b0;
      data_in_98 <= 8'b0;
      data_in_99 <= 8'b0;
      data_in_100 <= 8'b0;
      data_in_101 <= 8'b0;
      data_in_102 <= 8'b0;
      data_in_103 <= 8'b0;
      data_in_104 <= 8'b0;
      data_in_105 <= 8'b0;
      data_in_106 <= 8'b0;
      data_in_107 <= 8'b0;
      data_in_108 <= 8'b0;
      data_in_109 <= 8'd0;   
      data_in_110 <= 8'd0;
      data_in_111 <= 8'd0;
      data_in_112 <= 8'd0;
      data_in_113 <= 8'd0;
      data_in_114 <= 8'd0;
      data_in_115 <= 8'd0;
      data_in_116 <= 8'd0;
      data_in_117 <= 8'd0;
      data_in_118 <= 8'd0;
      data_in_119 <= 8'd0;
      data_in_120 <= 8'd0;
      data_in_121 <= 8'd0;
      data_in_122 <= 8'd0;
      data_in_123 <= 8'd0;
      data_in_124 <= 8'd0;
      data_in_125 <= 8'd0;
      data_in_126 <= 8'd0;
      data_in_127 <= 8'd0;
      data_in_128 <= 8'd0;	  
    end
    else begin
      data_in_0  <= data_in;
      data_in_1  <= data_in_0 ;
      data_in_2  <= data_in_1 ;
      data_in_3  <= data_in_2 ;
      data_in_4  <= data_in_3 ;
      data_in_5  <= data_in_4 ;
      data_in_6  <= data_in_5 ;
      data_in_7  <= data_in_6 ;
      data_in_8  <= data_in_7 ;
      data_in_9  <= data_in_8 ;
      data_in_10 <= data_in_9 ;
      data_in_11 <= data_in_10;
      data_in_12 <= data_in_11;
      data_in_13 <= data_in_12;
      data_in_14 <= data_in_13;
      data_in_15 <= data_in_14;
      data_in_16 <= data_in_15;
      data_in_17 <= data_in_16;
      data_in_18 <= data_in_17;
      data_in_19 <= data_in_18;
      data_in_20 <= data_in_19;
      data_in_21 <= data_in_20;
      data_in_22 <= data_in_21;
      data_in_23 <= data_in_22;
      data_in_24 <= data_in_23;
      data_in_25 <= data_in_24;
      data_in_26 <= data_in_25;
      data_in_27 <= data_in_26;
      data_in_28 <= data_in_27;
      data_in_29 <= data_in_28;
      data_in_30 <= data_in_29;
      data_in_31 <= data_in_30;
      data_in_32 <= data_in_31;
      data_in_33 <= data_in_32;
      data_in_34 <= data_in_33;
      data_in_35 <= data_in_34;
      data_in_36 <= data_in_35;
      data_in_37 <= data_in_36;
      data_in_38 <= data_in_37;
      data_in_39 <= data_in_38;
      data_in_40 <= data_in_39;
      data_in_41 <= data_in_40;
      data_in_42 <= data_in_41;
      data_in_43 <= data_in_42;
      data_in_44 <= data_in_43;
      data_in_45 <= data_in_44;
      data_in_46 <= data_in_45;
      data_in_47 <= data_in_46;
      data_in_48 <= data_in_47;
      data_in_49 <= data_in_48;   
      data_in_50 <= data_in_49;
      data_in_51 <= data_in_50;
      data_in_52 <= data_in_51;
      data_in_53 <= data_in_52;
      data_in_54 <= data_in_53;
      data_in_55 <= data_in_54;
      data_in_56 <= data_in_55;
      data_in_57 <= data_in_56;
      data_in_58 <= data_in_57;
      data_in_59 <= data_in_58;
      data_in_60 <= data_in_59;
      data_in_61 <= data_in_60;
      data_in_62 <= data_in_61;
      data_in_63 <= data_in_62;
      data_in_64 <= data_in_63;
      data_in_65 <= data_in_64;
      data_in_66 <= data_in_65;
      data_in_67 <= data_in_66;
      data_in_68 <= data_in_67;
      data_in_69 <= data_in_68;
      data_in_70 <= data_in_69; 
	   
      data_in_71 <= data_in_70;
      data_in_72 <= data_in_71;
      data_in_73 <= data_in_72;
      data_in_74 <= data_in_73;
      data_in_75 <= data_in_74;
      data_in_76 <= data_in_75;
      data_in_77 <= data_in_76;
      data_in_78 <= data_in_77;
      data_in_79 <= data_in_78;
      data_in_80 <= data_in_79;
      data_in_81 <= data_in_80;
      data_in_82 <= data_in_81;
      data_in_83 <= data_in_82;
      data_in_84 <= data_in_83;
      data_in_85 <= data_in_84;
      data_in_86 <= data_in_85;
      data_in_87 <= data_in_86;
      data_in_88 <= data_in_87;
      data_in_89 <= data_in_88;
	  data_in_90 <= data_in_89;
      data_in_91 <= data_in_90;
      data_in_92 <= data_in_91;
      data_in_93 <= data_in_92;
      data_in_94 <= data_in_93;
      data_in_95 <= data_in_94;
      data_in_96 <= data_in_95;
      data_in_97 <= data_in_96;
      data_in_98 <= data_in_97;
      data_in_99 <= data_in_98;
      data_in_100 <= data_in_99;
      data_in_101 <= data_in_100;
      data_in_102 <= data_in_101;
      data_in_103 <= data_in_102;
      data_in_104 <= data_in_103;
      data_in_105 <= data_in_104;
      data_in_106 <= data_in_105;
      data_in_107 <= data_in_106;
      data_in_108 <= data_in_107;
      data_in_109 <= data_in_108;
      data_in_110 <= data_in_109;
      data_in_111 <= data_in_110;
      data_in_112 <= data_in_111;
      data_in_113 <= data_in_112;
      data_in_114 <= data_in_113;
      data_in_115 <= data_in_114;
      data_in_116 <= data_in_115;
      data_in_117 <= data_in_116;
      data_in_118 <= data_in_117;
      data_in_119 <= data_in_118;   
      data_in_120 <= data_in_119;
      data_in_121 <= data_in_120;
      data_in_122 <= data_in_121;
      data_in_123 <= data_in_122;
      data_in_124 <= data_in_123;
      data_in_125 <= data_in_124;
      data_in_126 <= data_in_125;
      data_in_127 <= data_in_126;
      data_in_128 <= data_in_127;
      
    end            
  end    
  
  always @ ( * ) begin
  	case(delay_clk_num)
      8'd0 : begin data_delay_out = data_in   ; end
      8'd1 : begin data_delay_out = data_in_0 ; end
      8'd2 : begin data_delay_out = data_in_1 ; end
      8'd3 : begin data_delay_out = data_in_2 ; end
      8'd4 : begin data_delay_out = data_in_3 ; end
      8'd5 : begin data_delay_out = data_in_4 ; end
      8'd6 : begin data_delay_out = data_in_5 ; end
      8'd7 : begin data_delay_out = data_in_6 ; end
      8'd8 : begin data_delay_out = data_in_7 ; end
      8'd9 : begin data_delay_out = data_in_8 ; end
      8'd10: begin data_delay_out = data_in_9 ; end
      8'd11: begin data_delay_out = data_in_10; end
      8'd12: begin data_delay_out = data_in_11; end
      8'd13: begin data_delay_out = data_in_12; end
      8'd14: begin data_delay_out = data_in_13; end
      8'd15: begin data_delay_out = data_in_14; end
      8'd16: begin data_delay_out = data_in_15; end
      8'd17: begin data_delay_out = data_in_16; end
      8'd18: begin data_delay_out = data_in_17; end
      8'd19: begin data_delay_out = data_in_18; end
      8'd20: begin data_delay_out = data_in_19; end
      8'd21: begin data_delay_out = data_in_20; end
      8'd22: begin data_delay_out = data_in_21; end
      8'd23: begin data_delay_out = data_in_22; end
      8'd24: begin data_delay_out = data_in_23; end
      8'd25: begin data_delay_out = data_in_24; end
      8'd26: begin data_delay_out = data_in_25; end
      8'd27: begin data_delay_out = data_in_26; end
      8'd28: begin data_delay_out = data_in_27; end
      8'd29: begin data_delay_out = data_in_28; end
      8'd30: begin data_delay_out = data_in_29; end
      8'd31: begin data_delay_out = data_in_30; end
      8'd32: begin data_delay_out = data_in_31; end
      8'd33: begin data_delay_out = data_in_32; end
      8'd34: begin data_delay_out = data_in_33; end
      8'd35: begin data_delay_out = data_in_34; end
      8'd36: begin data_delay_out = data_in_35; end
      8'd37: begin data_delay_out = data_in_36; end
      8'd38: begin data_delay_out = data_in_37; end
      8'd39: begin data_delay_out = data_in_38; end
      8'd40: begin data_delay_out = data_in_39; end
      8'd41: begin data_delay_out = data_in_40; end
      8'd42: begin data_delay_out = data_in_41; end
      8'd43: begin data_delay_out = data_in_42; end
      8'd44: begin data_delay_out = data_in_43; end
      8'd45: begin data_delay_out = data_in_44; end
      8'd46: begin data_delay_out = data_in_45; end
      8'd47: begin data_delay_out = data_in_46; end
      8'd48: begin data_delay_out = data_in_47; end
      8'd49: begin data_delay_out = data_in_48; end
      8'd50: begin data_delay_out = data_in_49; end	
      8'd51: begin data_delay_out = data_in_50; end
      8'd52: begin data_delay_out = data_in_51; end
      8'd53: begin data_delay_out = data_in_52; end
      8'd54: begin data_delay_out = data_in_53; end
      8'd55: begin data_delay_out = data_in_54; end
      8'd56: begin data_delay_out = data_in_55; end
      8'd57: begin data_delay_out = data_in_56; end
      8'd58: begin data_delay_out = data_in_57; end
      8'd59: begin data_delay_out = data_in_58; end
      8'd60: begin data_delay_out = data_in_59; end
      8'd61: begin data_delay_out = data_in_60; end
      8'd62: begin data_delay_out = data_in_61; end
      8'd63: begin data_delay_out = data_in_62; end
      8'd64: begin data_delay_out = data_in_63; end
      8'd65: begin data_delay_out = data_in_64; end
      8'd66: begin data_delay_out = data_in_65; end
      8'd67: begin data_delay_out = data_in_66; end
      8'd68: begin data_delay_out = data_in_67; end
      8'd69: begin data_delay_out = data_in_68; end
      8'd70: begin data_delay_out = data_in_69; end
      8'd71: begin data_delay_out = data_in_70; end
      8'd72: begin data_delay_out = data_in_71; end
      8'd73: begin data_delay_out = data_in_72; end
      8'd74: begin data_delay_out = data_in_73; end
      8'd75: begin data_delay_out = data_in_74; end
      8'd76: begin data_delay_out = data_in_75; end
      8'd77: begin data_delay_out = data_in_76; end
      8'd78: begin data_delay_out = data_in_77; end
      8'd79: begin data_delay_out = data_in_78; end
      8'd80: begin data_delay_out = data_in_79; end
      8'd81: begin data_delay_out = data_in_80; end
      8'd82: begin data_delay_out = data_in_81; end
      8'd83: begin data_delay_out = data_in_82; end
      8'd84: begin data_delay_out = data_in_83; end
      8'd85: begin data_delay_out = data_in_84; end
      8'd86: begin data_delay_out = data_in_85; end
      8'd87: begin data_delay_out = data_in_86; end
      8'd88: begin data_delay_out = data_in_87; end
      8'd89: begin data_delay_out = data_in_88; end
      8'd90: begin data_delay_out = data_in_89; end
      8'd91: begin data_delay_out = data_in_90; end
      8'd92: begin data_delay_out = data_in_91; end
      8'd93: begin data_delay_out = data_in_92; end
      8'd94: begin data_delay_out = data_in_93; end
      8'd95: begin data_delay_out = data_in_94; end
      8'd96: begin data_delay_out = data_in_95; end
      8'd97: begin data_delay_out = data_in_96; end
      8'd98: begin data_delay_out = data_in_97; end
      8'd99: begin data_delay_out = data_in_98; end
      8'd100: begin data_delay_out = data_in_99; end
      8'd101: begin data_delay_out = data_in_100; end
      8'd102: begin data_delay_out = data_in_101; end
      8'd103: begin data_delay_out = data_in_102; end
      8'd104: begin data_delay_out = data_in_103; end
      8'd105: begin data_delay_out = data_in_104; end
      8'd106: begin data_delay_out = data_in_105; end
      8'd107: begin data_delay_out = data_in_106; end
      8'd108: begin data_delay_out = data_in_107; end
      8'd109: begin data_delay_out = data_in_108; end
      8'd110: begin data_delay_out = data_in_109; end	
      8'd111: begin data_delay_out = data_in_110; end
      8'd112: begin data_delay_out = data_in_111; end
      8'd113: begin data_delay_out = data_in_112; end
      8'd114: begin data_delay_out = data_in_113; end
      8'd115: begin data_delay_out = data_in_114; end
      8'd116: begin data_delay_out = data_in_115; end
      8'd117: begin data_delay_out = data_in_116; end
      8'd118: begin data_delay_out = data_in_117; end
      8'd119: begin data_delay_out = data_in_118; end
      8'd120: begin data_delay_out = data_in_119; end
      8'd121: begin data_delay_out = data_in_120; end
      8'd122: begin data_delay_out = data_in_121; end
      8'd123: begin data_delay_out = data_in_122; end
      8'd124: begin data_delay_out = data_in_123; end
      8'd125: begin data_delay_out = data_in_124; end
      8'd126: begin data_delay_out = data_in_125; end
      8'd127: begin data_delay_out = data_in_126; end
      8'd128: begin data_delay_out = data_in_127; end
	  8'd129: begin data_delay_out = data_in_128; end
     
  		default: begin
  	    data_delay_out = data_in;        
  		end 
    endcase
  end 
  
endmodule




















////////////////////////////
