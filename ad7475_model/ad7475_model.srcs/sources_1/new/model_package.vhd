---------------------------------------------------------------------------------- 
-- Engineer: Caio Lorenzo Iriarte Salles
-- Create Date: 07.12.2024 22:58:26
-- 
-- Module Name: model_package - AD7475 Package Definition
-- Project Name: ADC Model AD7475
--
-- Dependencies: None
-- 
-- Revision:
-- Revision 0.01 - File Created 
---------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


-- Package Declaration Section
package model_package is
    --  Data width constant (ADC AD7475 uses 12bits)
    constant data_w : integer := 12;
    constant msg_w : integer := data_w + 4;
    constant v_max : real := 2.50;
    
    --  Definition of IN voltage for ADC conversion
    type in_voltage is range 0.00 to v_max;
    signal v_in : in_voltage := 0.00;
    
    --  String to voltage: generate in_voltage from string value
    function str_to_volt(input_str : string) return in_voltage;
    
    --  Voltage to std_logic_vector (msg_w bits)
    function volt_to_vec(in_volt : in_voltage) return std_logic_vector;
end package model_package;


-- Package Body Section
package body model_package is
    --  String to voltage: function definition
    function str_to_volt(input_str : string) return in_voltage is
        variable real_val : real := 0.0;
        variable result : in_voltage := 0.00;
    begin
        real_val := real'value(input_str);
        result := in_voltage(real_val);
        return result;
    end function;
    
    
    --  Voltage to std_logic_vector definition
    function volt_to_vec(in_volt : in_voltage) return std_logic_vector is
        variable ret_vec : std_logic_vector(msg_w downto 1) := (others => '0');
        variable int_val : integer := 0;
        variable max_val : integer := 2**data_w - 1;
    begin
        int_val := integer(real(in_volt)*(real(max_val)/v_max));
        ret_vec := std_logic_vector(to_unsigned(int_val, ret_vec'length));
        
        --  Return value converted to std_logic_vector (12bits)
        return ret_vec;
    end function;
end package body model_package;
