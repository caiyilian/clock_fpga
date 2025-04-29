module split (
    input wire clk,       // 输入时钟信号
    input wire reset,     // 复位信号
    output reg clk_out    // 输出分频后的时钟信号
);
    
 reg [25:0] count; // 计数器，用于存储计数值

 // 50MHz 到 1Hz 分频比是 50000000
 parameter DIV = 50000000 / 2; // 计数到 DIV 时翻转输出时钟

 always @(posedge clk) begin
	  if (reset) begin
			count <= 0;       // 异步复位，计数器清零
			clk_out <= 0;     // 异步复位，输出时钟低电平
	  end else begin
			count <= count + 1; // 计数器递增
			if (count >= DIV) begin
				 clk_out <= ~clk_out; // 当计数达到 DIV 时翻转输出时钟
				 count <= 0;          // 计数器清零
			end
	  end
 end

endmodule
