module hazard(fetch_rd, fetch_op, fetch_pc_plus_4, decode_rs1, decode_rs2, decode_pc_plus_4, load_bubble, branch_bubble);
    
    output load_bubble, branch_bubble;
    input [0:4] fetch_rd, decode_rs1, decode_rs2;
    input [0:5] fetch_op;

    assign load_bubble =
        ((fetch_op[3:5] == 3'b100) & ((fetch_rd = decode_rs1) | (fetch_rd == decode_rs2)));
    assign branch_bubble = 
        (((fetch_op[0:5] >= 6'h04) & (fetch_op[0:5] <= 6'h07)) & (fetch_pc_plus_4 != decode_pc_plus_4));

endmodule
