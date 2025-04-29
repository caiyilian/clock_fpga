module split_50ms (
    input wire clk,       // 输入时钟信号
    input wire reset,     // 复位信号
    output reg clk_out_50ms    // 输出分频后的时钟信号（50ms周期）
);

    reg [23:0] count_50ms; // 计数器，24位足够

    // 50MHz 到 20Hz（50ms周期）分频比是 2,500,000
    parameter DIV_50MS = 2500000 / 2; // 计数到DIV_50MS时翻转输出

    always @(posedge clk) begin
        if (reset) begin
            count_50ms <= 0;
            clk_out_50ms <= 0;
        end else begin
            count_50ms <= count_50ms + 1;
            if (count_50ms >= DIV_50MS) begin
                clk_out_50ms <= ~clk_out_50ms;
                count_50ms <= 0;
            end
        end
    end

endmodule