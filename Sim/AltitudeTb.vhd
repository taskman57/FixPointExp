--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:08:11 09/28/2015
-- Design Name:   
-- Module Name:   E:/Embedded/Pressure/press_tester.vhd
-- Project Name:  Pressure
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: pressure
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_textio.all; 
use STD.textio.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tester IS
END tester;
 
ARCHITECTURE behavior OF tester IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Altitude
    PORT(
		iCLK			: in STD_LOGIC;
		iReset		    : in STD_LOGIC;
		iNewData		: in STD_LOGIC;		
		iX				: in STD_LOGIC_VECTOR (15 downto 0);
		oDataReady	    : out STD_LOGIC;
		oAltitude	    : out STD_LOGIC_VECTOR (15 downto 0)
    );
    END COMPONENT;

    --Inputs
    signal iCLK : std_logic := '0';
    signal iReset : std_logic := '1';
    signal iX : std_logic_vector(15 downto 0) := (others => '0');
	signal iNewData : std_logic := '0';
 	--Outputs
    signal oAltitude : std_logic_vector(15 downto 0);
    signal oDataReady	: std_logic;

    -- Clock period definitions
    constant iCLK_period : time := 10 ns;
    type ROM is array(0 to 100) of integer range 0 to 65535;
    signal sROM : ROM:=(
        0,
        409,
        819,
        1228,
        1638,
        2048,
        2457,
        2867,
        3276,
        3686,
        4096,
        4505,
        4915,
        5324,
        5734,
        6144,
        6553,
        6963,
        7372,
        7782,
        8192,
        8601,
        9011,
        9420,
        9830,
        10240,
        10649,
        11059,
        11468,
        11878,
        12288,
        12697,
        13107,
        13516,
        13926,
        14336,
        14745,
        15155,
        15564,
        15974,
        16384,
        16793,
        17203,
        17612,
        18022,
        18432,
        18841,
        19251,
        19660,
        20070,
        20480,
        20889,
        21299,
        21708,
        22118,
        22528,
        22937,
        23347,
        23756,
        24166,
        24576,
        24985,
        25395,
        25804,
        26214,
        26624,
        27033,
        27443,
        27852,
        28262,
        28672,
        29081,
        29491,
        29900,
        30310,
        30720,
        31129,
        31539,
        31948,
        32358,
        32768,
        33177,
        33587,
        33996,
        34406,
        34815,
        35225,
        35635,
        36044,
        36454,
        36863,
        37273,
        37683,
        38092,
        38502,
        38911,
        39321,
        39731,
        40140,
        40550,
        40959
    );
    signal sCTR : integer range 0 to 15;
    signal sROMCounter : integer range 0 to 100;
    signal sNotEnd : std_logic;
    file vWriteFile : TEXT;
BEGIN
    file_open(vWriteFile, "../../../../../Sim/AltitudeResults.dat", Write_MODE);
 
	-- Instantiate the Unit Under Test (UUT)
   uut:
    Altitude PORT MAP (
        iCLK => iCLK,
        iReset => iReset,
        iX => iX,
        iNewData => iNewData,
        oDataReady => oDataReady,
        oAltitude => oAltitude
    );

    -- Clock process definitions
    iCLK_process :
    process
    begin
        iCLK <= '0';
        wait for iCLK_period/2;
        iCLK <= '1';
        wait for iCLK_period/2;
    end process;

   -- Stimulus process
   stim_proc:
   process
   begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	
        wait for iCLK_period*10;
        iReset <= '1', '0' after 10*iClk_period;
        wait;
    end process;

    process(iCLK)
    variable		vWriteLine		: line;
    variable		vWriteData		: std_logic_vector(15 downto 0);
    begin
        if rising_edge(iCLK) then
            if iReset = '1' then
                sCTR <= 0;
                sROMCounter <= 0;
                sNotEnd <= '1';
            else
                if sCTR < 13 then
                    sCTR <= sCTR + 1;
                    iNewData <= '0';
                else
                    if sNotEnd = '1' then
                        iNewData <= '1';
                        sCTR <= 0;
                        iX <= conv_std_logic_vector(sROM(sROMCounter),16);
    ------------------------------------------------------------------------
                        if sROMCounter < 100 then
                            sROMCounter <= sROMCounter + 1;
                        end if;
                    end if;
                end if;

                if oDataReady = '1' then
                    vWriteData := oAltitude;
                    hwrite(vWriteLine, vWriteData);
                    writeline(vWriteFile, vWriteLine);
                    if sROMCounter = 100 then
                        sNotEnd <= '0';
                    end if;
                end if;
            end if;
        end if;
    end process;
END ARCHITECTURE;
