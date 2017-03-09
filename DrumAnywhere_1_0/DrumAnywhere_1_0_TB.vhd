LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY DrumAnywhere_1_0_TB IS
END DrumAnywhere_1_0_TB;
 
ARCHITECTURE behavior OF DrumAnywhere_1_0_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
   component niosII_system is
        port (
            clk_clk                                 : in    std_logic                     := 'X';             -- clk
            reset_reset_n                           : in    std_logic                     := 'X';             -- reset_n
            sdram_0_wire_addr                       : out   DE2_SDRAM_ADDR_BUS;                    -- addr
            sdram_0_wire_ba                         : out   std_logic_vector(1 downto 0);                     -- ba
            sdram_0_wire_cas_n                      : out   std_logic;                                        -- cas_n
            sdram_0_wire_cke                        : out   std_logic;                                        -- cke
            sdram_0_wire_cs_n                       : out   std_logic;                                        -- cs_n
            sdram_0_wire_dq                         : inout DE2_SDRAM_DATA_BUS := (others => 'X'); -- dq
            sdram_0_wire_dqm                        : out   std_logic_vector(1 downto 0);                     -- dqm
            sdram_0_wire_ras_n                      : out   std_logic;                                        -- ras_n
            sdram_0_wire_we_n                       : out   std_logic;                                        -- we_n
            altpll_0_c0_clk                         : out   std_logic;                                        -- clk
            green_leds_external_connection_export   : out   DE2_LED_GREEN;                     -- export
            sram_0_external_interface_DQ            : inout DE2_SRAM_DATA_BUS := (others => 'X'); -- DQ
            sram_0_external_interface_ADDR          : out   DE2_SRAM_ADDR_BUS;                    -- ADDR
            sram_0_external_interface_LB_N          : out   std_logic;                                        -- LB_N
            sram_0_external_interface_UB_N          : out   std_logic;                                        -- UB_N
            sram_0_external_interface_CE_N          : out   std_logic;                                        -- CE_N
            sram_0_external_interface_OE_N          : out   std_logic;                                        -- OE_N
            sram_0_external_interface_WE_N          : out   std_logic;                                        -- WE_N
            character_lcd_0_external_interface_DATA : inout DE2_LCD_DATA_BUS  := (others => 'X'); -- DATA
            character_lcd_0_external_interface_ON   : out   std_logic;                                        -- ON
            character_lcd_0_external_interface_BLON : out   std_logic;                                        -- BLON
            character_lcd_0_external_interface_EN   : out   std_logic;                                        -- EN
            character_lcd_0_external_interface_RS   : out   std_logic;                                        -- RS
            character_lcd_0_external_interface_RW   : out   std_logic;                                         -- RW
        clk_1_clk                                        : in    std_logic                     := 'X';             -- clk
            audio_and_video_config_0_external_interface_SDAT : inout std_logic;             -- SDAT
            audio_and_video_config_0_external_interface_SCLK : out   std_logic;                                        -- SCLK
            audio_0_external_interface_ADCDAT                : in    std_logic;             -- ADCDAT
            audio_0_external_interface_ADCLRCK               : in    std_logic;             -- ADCLRCK
            audio_0_external_interface_BCLK                  : in    std_logic;             -- BCLK
            audio_0_external_interface_DACDAT                : out   std_logic;                                        -- DACDAT
            audio_0_external_interface_DACLRCK               : in    std_logic;
        up_clocks_0_audio_clk_clk                        : out   std_logic;         -- clk        -- DACLRCK
        spi_0_external_MISO                              : in    std_logic                     := 'X';             -- MISO
            spi_0_external_MOSI                              : out   std_logic;                                        -- MOSI
            spi_0_external_SCLK                              : out   std_logic;                                        -- SCLK
            spi_0_external_SS_n                              : out   std_logic;                                        -- SS_n
        buttons_external_connection_export               : in    std_logic_vector(3 downto 0)  := (others => 'X')  -- export
        );
    end component niosII_system;
    

   --Inputs
   signal adcdat: std_logic;
   signal adclrck: std_logic;
   signal bclk: std_logic;
   signal daclrck : std_logic;
   signal miso: std_logic;

 	--Outputs
   signal mosi : std_logic;
   signal ss_n : std_logic;
   signal dacdat : std_logic;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DrumAnywhere_1_0 PORT MAP (
          adcdat => audio_0_external_interface_ADCDAT,
          adclrck => audio_0_external_interface_ADCLRCK,
          bclk => audio_0_external_interface_BCLK,
          daclrck => audio_0_external_interface_DACLRCK,
          miso => spi_0_external_MISO,

          mosi => spi_0_external_MOSI,
          ss_n => spi_0_external_SS_n ,
          dacdat =>  audio_0_external_interface_DACDAT 
        );

   -- Stimulus process
   stim_proc: process
   begin		
    -- insert stimulus here 
		adcdat<='1'; adclrck<= '0'; bclk <= '0'; daclrck <= '0'; miso <= '0';
		Wait for 20ns;
		adcdat<='1'; adclrck<= '0'; bclk <= '0'; daclrck <= '0'; miso <= '1';
		Wait for 20ns;
		adcdat<='1'; adclrck<= '0'; bclk <= '0'; daclrck <= '1'; miso <= '0';
		Wait for 20ns;
		adcdat<='1'; adclrck<= '0'; bclk <= '0'; daclrck <= '1'; miso <= '1';
		Wait for 20ns;
    adcdat<='1'; adclrck<= '0'; bclk <= '1'; daclrck <= '0'; miso <= '0';
    Wait for 20ns;
    adcdat<='1'; adclrck<= '1'; bclk <= '0'; daclrck <= '0'; miso <= '1';

      wait;
   end process;

END;