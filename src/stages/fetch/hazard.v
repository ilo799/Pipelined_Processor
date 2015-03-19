module hazard(decode_rd, fetch_op, decode_op, fetch_pc_plus_4, fetch_rs1, fetch_rs2, decode_pc_plus_4, need_nop, pc_stall, branch_hazard);

    output need_nop, pc_stall, branch_hazard;
    input [0:5] decode_rd, fetch_rs1, fetch_rs2;
    input [0:5] fetch_op, decode_op;
    input [0:31] fetch_pc_plus_4, decode_pc_plus_4;

    wire load_bubble, branch_bubble, branch_hazard1, jr_bubble;
    assign branch_hazard = branch_hazard1; 

    assign load_bubble =
        ((decode_op >= 6'h20 & decode_op <= 6'h27) & ((decode_rd == fetch_rs1) | (decode_rd == fetch_rs2)));

    assign branch_hazard1 =
        ((fetch_op[0:5] >= 6'h04) & (fetch_op[0:5] <= 6'h07) & (fetch_rs1 == decode_rd));

    assign branch_bubble =
        ((fetch_op[0:5] >= 6'h04) & (fetch_op[0:5] <= 6'h07) & (fetch_pc_plus_4 != decode_pc_plus_4));

    assign jr_bubble = ((fetch_op[0:5] == 6'h12 | fetch_op[0:5] == 6'h13) & (fetch_pc_plus_4 != decode_pc_plus_4));

    assign need_nop = load_bubble | branch_hazard1;

    assign pc_stall = branch_bubble | load_bubble | jr_bubble;

endmodule
