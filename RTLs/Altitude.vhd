----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:19:21 09/29/2015 
-- Design Name: 
-- Module Name:    Altitude - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Altitude is
    Port(
        iCLK        : in  STD_LOGIC;
        iReset     : in  STD_LOGIC;
        iX          : in  STD_LOGIC_VECTOR (15 downto 0);
        iNewData    : in  STD_LOGIC;
        oAltitude   : out  STD_LOGIC_VECTOR (15 downto 0);
        oDataReady  : out  STD_LOGIC
    );
end Altitude;

architecture Behavioral of Altitude is

    type tCtrlState is (Idle, Multiply, Add, Result);
    signal sCurrentState : tCtrlState := Idle;

    constant cCONST1    : signed(16 downto 0):= to_signed(-577,17);
    constant cCONST2    : signed(16 downto 0):= to_signed(57910,17);
    constant cCONST3    : signed(16 downto 0):= to_signed(33610,17);
    signal sBUF_Data    : std_logic;--used to detect rising edge upon data
    signal sSquared     : signed (33 downto 0);-- register used to hold input squared
    signal sCXPow2      : signed (50 downto 0);-- register used to hold C.X2
    signal sBX          : signed (33 downto 0);-- register used to hold B.X
    signal sAltitude    : signed (16 downto 0);-- register used to hold temporary result

begin
    FSM:
    process(iCLK)
    begin
        if rising_edge(iCLK) then
            if iReset =  '1' then
                sCurrentState   <= Idle;
                sBUF_Data       <= '0';
                oDataReady      <= '0';
                sSquared        <= (others => '0');
                sCXPow2         <= (others => '0');
                sBX             <= (others => '0');
                sAltitude       <= (others => '0');
                oAltitude       <= (others => '0');			
            else
                sBUF_Data <= iNewData;
                case sCurrentState is
                    when Idle =>
                        oDataReady <= '0';
                        if iNewData = '1' and sBUF_Data = '0' then
                            sSquared        <= signed('0' & iX) * signed('0' & iX);
                            sCurrentState   <= Multiply;
                        end if;
                    when Multiply =>
                        sCXPow2	<= sSquared * cCONST1;
                        sBX		<= signed('0' & iX) * cCONST2;
                        sCurrentState <= Add;
                    when Add =>
                        -- c.X^2 has 3 sign bits(2 are 0)!, B.X has 2 sign bits(1 is 0)
                        sAltitude <= cCONST3 + ("000" & sBX(32 downto 19)) + sCXPow2(48 downto 32);
                        sCurrentState <= Result;
                    when Result =>
                        oDataReady <= '1';
                        oAltitude <= std_logic_vector(sAltitude(sAltitude'high-1 downto 0));
                        sCurrentState <= Idle;
                    when others =>
                        null;
                end case;
            end if;
        end if;
    end process FSM;
end Behavioral;