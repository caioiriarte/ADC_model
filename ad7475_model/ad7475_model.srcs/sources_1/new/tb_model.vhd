---------------------------------------------------------------------------------- 
-- Engineer: Caio Lorenzo Iriarte Salles
-- Create Date: 07.12.2024 22:58:26
-- 
-- Module Name: tb_model - Testbench
-- Project Name: ADC Model AD7475
--
-- Dependencies: AD7475 Package
-- 
-- Revision:
-- Revision 0.01 - File Created 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library std;
use std.textio.all;
library ad7475_lib;
use ad7475_lib.model_package.all;


entity tb_model is
end tb_model;

---------------------------------------------------------
--  Testbench architecture definition (bus of AD7475)
architecture test of tb_model is

    --  Definition of the component
    component model_ad7475 is
        port(   SCLK    : in std_logic;
                CSN     : in std_logic;
                SDATA   : out std_logic := 'Z');
    end component;
    
    
    signal CLK_S : std_logic := '1';
    signal DATA_S : std_logic := '0';
    signal CSN_S : std_logic := '1';
    
    --  File read definition
    file data_file : text;

begin
    
    --  Instance definition
    U1 : model_ad7475
    port map (  SDATA => DATA_S,
                SCLK => CLK_S,
                CSN => CSN_S);

    ---------------------------------------------------
    --  Main process definition
    test: process
    
        --  Useful variables definition
        variable line_in : line;
        variable volt_in : string(4 downto 1);
        
        --  Retard definition process
        procedure wait_clk is
        begin
            CLK_S <= '0';
            wait for 10ns;
            CLK_S <= '1';
            wait for 10ns;
        end procedure;
        
        --  Procedure for waiting one CLK period
        procedure wait_process is
        begin
            wait for 20ns;
        end procedure;
        
        --  Procedure for waiting until SDATA has
        --  outcome the entire voltage value
        procedure wait_voltage is
            variable ite : integer range 0 to msg_w := 0;
        begin
            while ite /= msg_w loop
                wait_clk;
                ite := ite + 1;
            end loop;
        end procedure;
    
    begin
        
        --  Start data processing
        file_open(data_file,"../instructions.txt",READ_MODE);
        readline(data_file, line_in);
        readline(data_file, line_in);
        read(line_in,volt_in);
        
        wait_process;
        wait_process;
        
        --  Loop until end of file
        while volt_in /= "ENDF" loop
            v_in <= str_to_volt(volt_in);
            CSN_S <= '0';
            
            --  Data update
            wait_voltage;
            
            --  End of process
            CSN_S <= '1';
            readline(data_file, line_in);
            read(line_in,volt_in);
            wait_process;
            wait_process;
        end loop;
        
        -- Close the archive
        file_close(data_file);
    
        wait;
    end process;

end test;
