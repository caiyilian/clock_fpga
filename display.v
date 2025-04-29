module display (
    output reg [6:0] decodeout, // 显示段信号
    input [3:0] indec          // 输入数字
);

always @(indec) begin
    case(indec) // 用 case 语句进行译码
        4'd0: decodeout = 7'b1000000; // 0
        4'd1: decodeout = 7'b1111001; // 1
        4'd2: decodeout = 7'b0100100; // 2
        4'd3: decodeout = 7'b0110000; // 3
        4'd4: decodeout = 7'b0011001; // 4
        4'd5: decodeout = 7'b0010010; // 5
        4'd6: decodeout = 7'b0000010; // 6
        4'd7: decodeout = 7'b1111000; // 7
        4'd8: decodeout = 7'b0000000; // 8
        4'd9: decodeout = 7'b0011000; // 9
        default: decodeout=7'b1111111; // 默认情况
    endcase
end
endmodule
