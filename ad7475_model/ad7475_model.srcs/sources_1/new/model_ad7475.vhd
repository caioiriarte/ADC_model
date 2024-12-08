---------------------------------------------------------------------------------- 
-- Engineer: Caio Lorenzo Iriarte Salles
-- Create Date: 07.12.2024 22:58:26
-- 
-- Module Name: model_ad7475 - Entity Definition
-- Project Name: ADC Model AD7475
--
-- Dependencies: AD7475 Package
-- 
-- Revision:
-- Revision 0.01 - File Created 
---------------------------------------------------------------------------------



library ad7475_lib;
use ad7475_lib.model_package.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


--  Definition of the ADC bus simulated: AD7475
entity model_ad7475 is
    port(   SCLK    : in std_logic;
            CSN     : in std_logic;
            SDATA   : out std_logic := 'Z');
end model_ad7475;


--  Behave of the bus defined
architecture behave of model_ad7475 is

    signal int_data : integer range 0 to msg_w := msg_w;
    signal volt_vec : std_logic_vector(msg_w downto 1) := (others => '0');

begin

    process(SCLK,CSN)
        variable data_int : integer;
    begin
        if SCLK'event and SCLK = '0' then
            if CSN = '0' then
                --  Update vector value
                if int_data = msg_w then
                    volt_vec <= volt_to_vec(v_in);
                    SDATA <= volt_vec(int_data);
                    data_int := int_data - 1;
                    int_data <= data_int;
                elsif int_data > 0 then
                    SDATA <= volt_vec(int_data);
                    data_int := int_data - 1;
                    int_data <= data_int;
                else
                    SDATA <= 'Z';
                end if;
            end if;
        elsif CSN = '1' then
            int_data <= msg_w;
            SDATA <= 'Z';
        end if;
    end process;

end architecture;
