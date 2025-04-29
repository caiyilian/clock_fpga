module minute_counter (
    input wire clk,           // 输入时钟信号
    input wire reset,         // 复位信号
    input wire sec_carry,     // 秒进位信号，当秒计数器从59变为0时为高电平
    output reg [3:0] min_tens, // 分钟计数器的十位
    output reg [3:0] min_ones, // 分钟计数器的个位
    output reg min_carry      // 分钟进位信号，当分钟计数器从59变为0时为高电平
);

    // 定义分钟计数器
    reg [5:0] minutes; // 可以计数0-59
    reg sec_carry_prev;
    // 分钟计数器逻辑
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            minutes <= 58;       // 复位时计数器清零
            min_carry <= 0;     // 复位时进位信号清零
            sec_carry_prev <= 0;
        end else begin
      
            // 检测秒进位信号的上升沿
            if ((sec_carry == 1) && (sec_carry_prev == 0)) begin
                if (minutes == 59) begin
                    minutes <= 0;    // 当计数到59时，重置为0
                    min_carry <= 1;  // 进位信号置为高电平
                end else begin
                    minutes <= minutes + 1; // 不是59就计数器加1
                    min_carry <= 0;         // 清除进位信号
                end
            end else begin
                min_carry <= 0; // 在非进位时刻，确保进位信号为0
            end
				// 更新 sec_carry_prev
            sec_carry_prev <= sec_carry;
        end
    end

    // 将分钟转换为十位和个位
    always @(minutes) begin
        min_tens = minutes / 10; // 十位
        min_ones = minutes % 10; // 个位
    end

endmodule