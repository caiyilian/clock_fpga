module main (
    input wire clk_50MHz, // 50MHz输入时钟
    input wire reset,     // 复位信号
    input wire min_add,       // 分钟增加按钮
    input wire min_reduce,       // 分钟减少按钮
    input wire hour_add,       // 小时增加按钮
    input wire hour_reduce,       // 小时增加按钮
    // 秒显示数码管
    output wire [6:0] sec_seg_tens, // 秒十位数码管段信号
    output wire [6:0] sec_seg_ones, // 秒个位数码管段信号
    
    // 分显示数码管
    output wire [6:0] min_seg_tens, // 分十位数码管段信号
    output wire [6:0] min_seg_ones, // 分个位数码管段信号
    
    // 时显示数码管
    output wire [6:0] hour_seg_tens, // 时十位数码管段信号
    output wire [6:0] hour_seg_ones,  // 时个位数码管段信号
    output wire min_add_sig, // 输出分增加信号
    output wire min_reduce_sig, // 输出分减少信号
    output wire hour_add_sig, // 输出小时增加信号
    output wire hour_reduce_sig // 输出小时减少信号
);

    // 内部信号
    wire clk_1Hz;        // 1Hz时钟信号
    
    // 秒计数器信号
    wire [3:0] sec_tens; // 秒计数器的十位
    wire [3:0] sec_ones; // 秒计数器的个位
    wire sec_carry;      // 秒进位信号
    
    // 分钟计数器信号
    wire [3:0] min_tens; // 分钟计数器的十位
    wire [3:0] min_ones; // 分钟计数器的个位
    wire min_carry;      // 分钟进位信号
    // 小时计数器信号
    wire [3:0] hour_tens; // 小时计数器的十位
    wire [3:0] hour_ones; // 小时计数器的个位

    // 实例化分频器模块 - 将50MHz分频为1Hz
    split split_inst (
        .clk(clk_50MHz),
        .reset(reset),
        .clk_out(clk_1Hz)
    );
    // 实例化分频器模块 - 将50MHz分频为20Hz
    split_50ms split_50ms_inst (
        .clk(clk_50MHz),
        .reset(reset),
        .clk_out_50ms(clk_20Hz)
    );

    // 实例化秒计数器模块
    second_counter sec_counter_inst (
        .clk(clk_1Hz),
        .reset(reset),
        .sec_tens(sec_tens),
        .sec_ones(sec_ones),
        .sec_carry(sec_carry)
    );
    
    // 实例化分钟计数器模块
    minute_counter min_counter_inst (
        .clk(clk_20Hz),
        .reset(reset),
        .sec_carry(sec_carry),
        .min_add(min_add),
        .min_reduce(min_reduce),
        .min_tens(min_tens),
        .min_ones(min_ones),
        .min_carry(min_carry)
    );
    
    // 实例化小时计数器模块
    hour_counter hour_counter_inst (
        .clk(clk_50MHz),
        .reset(reset),
        .min_carry(min_carry),
        .hour_add(hour_add),
        .hour_reduce(hour_reduce),
        .hour_tens(hour_tens),
        .hour_ones(hour_ones)
    );

    // 实例化秒数码管显示模块
    display sec_tens_display (
        .indec(sec_tens),
        .decodeout(sec_seg_tens)
    );

    display sec_ones_display (
        .indec(sec_ones),
        .decodeout(sec_seg_ones)
    );
    
    // 实例化分钟数码管显示模块
    display min_tens_display (
        .indec(min_tens),
        .decodeout(min_seg_tens)
    );

    display min_ones_display (
        .indec(min_ones),
        .decodeout(min_seg_ones)
    );
    
    // 实例化小时数码管显示模块
    display hour_tens_display (
        .indec(hour_tens),
        .decodeout(hour_seg_tens)
    );

    display hour_ones_display (
        .indec(hour_ones),
        .decodeout(hour_seg_ones)
    );
    // 分增加和减少的按钮状态反映到led灯显示
    led min_add_btn_display (
        .btn(min_add),
        .led_sig(min_add_sig)
    );
    led min_reduce_btn_display (
        .btn(min_reduce),
        .led_sig(min_reduce_sig)
    );
    // 小时增加和减少的按钮状态反映到led灯显示
    led hour_add_btn_display (
        .btn(hour_add),
        .led_sig(hour_add_sig)
    );
    led hour_reduce_btn_display (
        .btn(hour_reduce),
        .led_sig(hour_reduce_sig)
    );
endmodule