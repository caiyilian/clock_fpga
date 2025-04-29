module led (
    input wire btn,       // 按钮信号
    output reg led_sig // 输出给led信号
);

	always @(btn) led_sig <= btn;

endmodule
