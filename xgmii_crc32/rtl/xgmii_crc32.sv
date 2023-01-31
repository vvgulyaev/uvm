 
module xgmii_crc32( 
                    input                 clk,
                    input                 rstn,
                    input        [63 : 0] xgmii_data,
                    input        [ 7 : 0] xgmii_ctrl,
                    output logic [31 : 0] crc32_o,
                    output logic          crc32_vld_o
                   );
    
    localparam logic [7:0] CODE_START = 'hFB;
    localparam logic [7:0] CODE_TERM  = 'hFD;
    
    logic          crc32_calc_in_progress, crc32_calc_in_progress_r;
    logic [ 3 : 0] pos_of_term, pos_of_term_r;
    logic [31 : 0] crc32_w, crc32_r;
    logic [31 : 0] crc32;
    logic          crc32_vld;
    logic [63 : 0] xgmii_data_r;
    logic [ 7 : 0] xgmii_ctrl_r;
    logic          term_not_found;

    always_ff @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            crc32_calc_in_progress_r <= 0;
            crc32_r                  <= 32'hFFFFFFFF;
            pos_of_term_r            <= 0;
            xgmii_data_r             <= 0;
            xgmii_ctrl_r             <= 0;
        end
        else begin
            crc32_calc_in_progress_r <= crc32_calc_in_progress;
            crc32_r                  <= crc32_calc_in_progress ? crc32 : 32'hFFFFFFFF;
            pos_of_term_r            <= pos_of_term;
            xgmii_data_r             <= xgmii_data;
            xgmii_ctrl_r             <= xgmii_ctrl;
        end
    end
    
    always_comb begin
        pos_of_term = getPosOfTerm(xgmii_data, xgmii_ctrl);
    end
    
    always_comb begin
        crc32_calc_in_progress = crc32_calc_in_progress_r;
        crc32_w = crc32_r;
        crc32_vld = 0;
        term_not_found = pos_of_term_r[3];
        
        if ((xgmii_data_r[7:0]==CODE_START) && xgmii_ctrl_r[0] && ~crc32_calc_in_progress_r) begin
            crc32_calc_in_progress = term_not_found;
            crc32_w = 32'hFFFFFFFF;
            crc32_vld = ~term_not_found;
        end
        else if (crc32_calc_in_progress_r & ~term_not_found) begin
            crc32_vld = 1;
            crc32_calc_in_progress = 0;
        end
    end
    //assign crc32_o = crc32 ^ 32'hFFFFFFFF;
    
    always_ff @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            crc32_o <= 32'hFFFFFFFF;
            crc32_vld_o <= 0;
        end
        else begin
            crc32_o <= (crc32 ^ 32'hFFFFFFFF);
            crc32_vld_o <= crc32_vld;
        end
    end
    
    crc32_calc inst_crc32(
                            .xgmii_data  ( xgmii_data_r   ),
                            .xgmii_ctrl  ( xgmii_ctrl_r   ),
                            .pos_of_term ( pos_of_term_r  ),
                            .crc_i       ( crc32_w        ),
                            .crc_o       ( crc32          )
                        );

    function logic[3:0] getPosOfTerm(logic [63:0] data, logic[7:0] ctrl);
        getPosOfTerm = 'hF;
        for (int i=0; i<8; i++) begin
            if (getPosOfTerm[3] && ctrl[i] && (data[i*8 +: 8]==CODE_TERM)) begin
                getPosOfTerm = i;
            end
        end
    endfunction
endmodule
