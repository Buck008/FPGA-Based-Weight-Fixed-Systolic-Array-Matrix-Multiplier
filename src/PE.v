`timescale 1ns / 1ps

module PE
#(
    parameter data_width = 8,           //���ݿ��
    parameter array_m = 16,             //Array ����
    parameter array_n = 16,             //Array ���� 
    parameter log2_array_m = 4
)
(
    input                                                   clk,
    input                                                   set_w,      //�ߵ�ƽ����weight
    input                                                   rst_n,      //�͵�ƽ��Ч���첽
    input signed [data_width-1:0]                           x_in,
    input signed [data_width-1:0]                           w,
    input signed [2*data_width+log2_array_m-1:0]            psum_in,    //partial sum ����
    output reg signed [data_width-1:0]                      x_out,
    output reg signed [2*data_width+log2_array_m-1:0]       psum_out    //partial sum ���
);
reg signed [data_width-1:0] reg_w;

always @(posedge clk or negedge rst_n) begin
    if(~rst_n)begin
        psum_out <= 0;
        reg_w <= 0;
        x_out <= 0;
    end
    else begin
        if(set_w) 
            reg_w <=w;
        psum_out <= psum_in + x_in*reg_w;
        x_out <= x_in;
    end
end
endmodule
