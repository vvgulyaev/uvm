 
/*
uint_least32_t Crc32(const unsigned char * buf, size_t len)
{
    uint_least32_t crc = 0xFFFFFFFF;
    while (len--)
        crc = (crc >> 8) ^ Crc32Table[(crc ^ *buf++) & 0xFF];
    return crc ^ 0xFFFFFFFF;
}
*/
module crc32_calc(
                    input        [63 : 0] xgmii_data,
                    input        [ 7 : 0] xgmii_ctrl,
                    input        [ 3 : 0] pos_of_term,
                    input        [31 : 0] crc_i,
                    output logic [31 : 0] crc_o
                 );
    logic [31:0] Crc32Table[256] = '{
            32'h00000000, 32'h77073096, 32'hEE0E612C, 32'h990951BA,
            32'h076DC419, 32'h706AF48F, 32'hE963A535, 32'h9E6495A3,
            32'h0EDB8832, 32'h79DCB8A4, 32'hE0D5E91E, 32'h97D2D988,
            32'h09B64C2B, 32'h7EB17CBD, 32'hE7B82D07, 32'h90BF1D91,
            32'h1DB71064, 32'h6AB020F2, 32'hF3B97148, 32'h84BE41DE,
            32'h1ADAD47D, 32'h6DDDE4EB, 32'hF4D4B551, 32'h83D385C7,
            32'h136C9856, 32'h646BA8C0, 32'hFD62F97A, 32'h8A65C9EC,
            32'h14015C4F, 32'h63066CD9, 32'hFA0F3D63, 32'h8D080DF5,
            32'h3B6E20C8, 32'h4C69105E, 32'hD56041E4, 32'hA2677172,
            32'h3C03E4D1, 32'h4B04D447, 32'hD20D85FD, 32'hA50AB56B,
            32'h35B5A8FA, 32'h42B2986C, 32'hDBBBC9D6, 32'hACBCF940,
            32'h32D86CE3, 32'h45DF5C75, 32'hDCD60DCF, 32'hABD13D59,
            32'h26D930AC, 32'h51DE003A, 32'hC8D75180, 32'hBFD06116,
            32'h21B4F4B5, 32'h56B3C423, 32'hCFBA9599, 32'hB8BDA50F,
            32'h2802B89E, 32'h5F058808, 32'hC60CD9B2, 32'hB10BE924,
            32'h2F6F7C87, 32'h58684C11, 32'hC1611DAB, 32'hB6662D3D,
            32'h76DC4190, 32'h01DB7106, 32'h98D220BC, 32'hEFD5102A,
            32'h71B18589, 32'h06B6B51F, 32'h9FBFE4A5, 32'hE8B8D433,
            32'h7807C9A2, 32'h0F00F934, 32'h9609A88E, 32'hE10E9818,
            32'h7F6A0DBB, 32'h086D3D2D, 32'h91646C97, 32'hE6635C01,
            32'h6B6B51F4, 32'h1C6C6162, 32'h856530D8, 32'hF262004E,
            32'h6C0695ED, 32'h1B01A57B, 32'h8208F4C1, 32'hF50FC457,
            32'h65B0D9C6, 32'h12B7E950, 32'h8BBEB8EA, 32'hFCB9887C,
            32'h62DD1DDF, 32'h15DA2D49, 32'h8CD37CF3, 32'hFBD44C65,
            32'h4DB26158, 32'h3AB551CE, 32'hA3BC0074, 32'hD4BB30E2,
            32'h4ADFA541, 32'h3DD895D7, 32'hA4D1C46D, 32'hD3D6F4FB,
            32'h4369E96A, 32'h346ED9FC, 32'hAD678846, 32'hDA60B8D0,
            32'h44042D73, 32'h33031DE5, 32'hAA0A4C5F, 32'hDD0D7CC9,
            32'h5005713C, 32'h270241AA, 32'hBE0B1010, 32'hC90C2086,
            32'h5768B525, 32'h206F85B3, 32'hB966D409, 32'hCE61E49F,
            32'h5EDEF90E, 32'h29D9C998, 32'hB0D09822, 32'hC7D7A8B4,
            32'h59B33D17, 32'h2EB40D81, 32'hB7BD5C3B, 32'hC0BA6CAD,
            32'hEDB88320, 32'h9ABFB3B6, 32'h03B6E20C, 32'h74B1D29A,
            32'hEAD54739, 32'h9DD277AF, 32'h04DB2615, 32'h73DC1683,
            32'hE3630B12, 32'h94643B84, 32'h0D6D6A3E, 32'h7A6A5AA8,
            32'hE40ECF0B, 32'h9309FF9D, 32'h0A00AE27, 32'h7D079EB1,
            32'hF00F9344, 32'h8708A3D2, 32'h1E01F268, 32'h6906C2FE,
            32'hF762575D, 32'h806567CB, 32'h196C3671, 32'h6E6B06E7,
            32'hFED41B76, 32'h89D32BE0, 32'h10DA7A5A, 32'h67DD4ACC,
            32'hF9B9DF6F, 32'h8EBEEFF9, 32'h17B7BE43, 32'h60B08ED5,
            32'hD6D6A3E8, 32'hA1D1937E, 32'h38D8C2C4, 32'h4FDFF252,
            32'hD1BB67F1, 32'hA6BC5767, 32'h3FB506DD, 32'h48B2364B,
            32'hD80D2BDA, 32'hAF0A1B4C, 32'h36034AF6, 32'h41047A60,
            32'hDF60EFC3, 32'hA867DF55, 32'h316E8EEF, 32'h4669BE79,
            32'hCB61B38C, 32'hBC66831A, 32'h256FD2A0, 32'h5268E236,
            32'hCC0C7795, 32'hBB0B4703, 32'h220216B9, 32'h5505262F,
            32'hC5BA3BBE, 32'hB2BD0B28, 32'h2BB45A92, 32'h5CB36A04,
            32'hC2D7FFA7, 32'hB5D0CF31, 32'h2CD99E8B, 32'h5BDEAE1D,
            32'h9B64C2B0, 32'hEC63F226, 32'h756AA39C, 32'h026D930A,
            32'h9C0906A9, 32'hEB0E363F, 32'h72076785, 32'h05005713,
            32'h95BF4A82, 32'hE2B87A14, 32'h7BB12BAE, 32'h0CB61B38,
            32'h92D28E9B, 32'hE5D5BE0D, 32'h7CDCEFB7, 32'h0BDBDF21,
            32'h86D3D2D4, 32'hF1D4E242, 32'h68DDB3F8, 32'h1FDA836E,
            32'h81BE16CD, 32'hF6B9265B, 32'h6FB077E1, 32'h18B74777,
            32'h88085AE6, 32'hFF0F6A70, 32'h66063BCA, 32'h11010B5C,
            32'h8F659EFF, 32'hF862AE69, 32'h616BFFD3, 32'h166CCF45,
            32'hA00AE278, 32'hD70DD2EE, 32'h4E048354, 32'h3903B3C2,
            32'hA7672661, 32'hD06016F7, 32'h4969474D, 32'h3E6E77DB,
            32'hAED16A4A, 32'hD9D65ADC, 32'h40DF0B66, 32'h37D83BF0,
            32'hA9BCAE53, 32'hDEBB9EC5, 32'h47B2CF7F, 32'h30B5FFE9,
            32'hBDBDF21C, 32'hCABAC28A, 32'h53B39330, 32'h24B4A3A6,
            32'hBAD03605, 32'hCDD70693, 32'h54DE5729, 32'h23D967BF,
            32'hB3667A2E, 32'hC4614AB8, 32'h5D681B02, 32'h2A6F2B94,
            32'hB40BBE37, 32'hC30C8EA1, 32'h5A05DF1B, 32'h2D02EF8D
        };
    logic [7:0]  crc32_tbl_idx;
    
    always_comb begin
        crc_o    = crc_i;
        for (int i=0; i<8; i++) begin
            crc32_tbl_idx = crc_o[7:0] ^ xgmii_data[8*i +: 8];
            if (~xgmii_ctrl[i] && (i <= pos_of_term)) begin
                crc_o = (Crc32Table[crc32_tbl_idx] ^ crc_o[31:8]);
            end
        end
    end
endmodule