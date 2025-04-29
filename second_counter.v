module second_counter (
    input wire clk,       // 输入时钟信号（1Hz，从分频器获得）
    input wire reset,     // 复位信号
    output reg [3:0] sec_tens, // 秒计数器的十位
    output reg [3:0] sec_ones, // 秒计数器的个位
    output reg sec_carry  // 秒进位信号，当秒计数器从59变为0时为高电平
);

    // 定义秒计数器
    reg [5:0] seconds; // 可以计数0-59

    // 秒计数器逻辑, posedge是上升沿的意思
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            seconds <= 50; // 复位时计数器清零
            sec_carry <= 0; // 复位时进位信号清零
        end else begin
            if (seconds == 59) begin
                seconds <= 0; // 当计数到59时，重置为0
                sec_carry <= 1; // 产生进位信号 
            end else begin
                seconds <= seconds + 1; // 不是59就计数器加1
                sec_carry <= 0; // 清除进位信号
            end
        end
    end

    // 将秒数转换为十位和个位
    always @(seconds) begin
        sec_tens = seconds / 10; // 十位
        sec_ones = seconds % 10; // 个位
    end

endmodule