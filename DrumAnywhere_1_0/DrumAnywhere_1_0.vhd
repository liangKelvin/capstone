-- Made by group 4 Drum Anywhere
-- Justin Jake Kelvin and Shivansh
library ieee;

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

	-- SIGNED and UNSIGNED types, and relevant functions
	use ieee.numeric_std.all;

	-- Basic sequential functions and concurrent procedures
	use ieee.VITAL_Primitives.all;
	
	use work.DE2_CONSTANTS.all;
	
	entity DrumAnywhere_1_0 is
	
	port
	(
		-- Input ports and 50 MHz Clock
		KEY		: in  std_logic_vector (3 downto 0);
		CLOCK_50	: in  std_logic;
		
		-- LCD on board
		LCD_BLON	: out std_logic;
		LCD_ON	: out std_logic;
		LCD_DATA	: inout DE2_LCD_DATA_BUS;
		LCD_RS	: out std_logic;
		LCD_EN	: out std_logic;
		LCD_RW	: out std_logic;
		
		-- SDRAM on board
		--DRAM_ADDR	:	out 	std_logic_vector (11 downto 0);
		DRAM_ADDR	:	out	DE2_SDRAM_ADDR_BUS;
		DRAM_BA_0	: 	out	std_logic;
		DRAM_BA_1	:	out	std_logic;
		DRAM_CAS_N	:	out	std_logic;
		DRAM_CKE		:	out	std_logic;
		DRAM_CLK		:	out	std_logic;
		DRAM_CS_N	:	out	std_logic;
		--DRAM_DQ		:	inout std_logic_vector (15 downto 0);
		DRAM_DQ		:	inout 	DE2_SDRAM_DATA_BUS;
		DRAM_LDQM	: 	out	std_logic;
		DRAM_UDQM	: 	out	std_logic;
		DRAM_RAS_N	: 	out	std_logic;
		DRAM_WE_N	: 	out 	std_logic;

		-- SRAM on board
		
		SRAM_ADDR	:	out	DE2_SRAM_ADDR_BUS;
		SRAM_DQ		:	inout DE2_SRAM_DATA_BUS;
		SRAM_WE_N	:	out	std_logic;
		SRAM_OE_N	:	out	std_logic;
		SRAM_UB_N	:	out 	std_logic;
		SRAM_LB_N	:	out	std_logic;
		SRAM_CE_N	:	out	std_logic;
		
		-- CLOCK port
		CLOCK_27 		:  in  		std_logic;
      
		--I2C interface
		I2C_SCLK			:  out		std_logic;
		I2C_SDAT			:  inout		std_logic;
					 
		--AUDIO 
		AUD_ADCLRCK 	:  inout 	std_logic; 
		AUD_ADCDAT 		:  in 		std_logic; 
		AUD_DACLRCK 	:  inout 	std_logic; 
		AUD_DACDAT 		:  out 		std_logic; 
		AUD_XCK 			:  out 		std_logic; 
		AUD_BCLK 		:  inout 	std_logic;
		
		--SD Card
		
		SD_DAT         : in       std_logic;
		SD_DAT3			: out			std_logic;
		SD_CLK			: out			std_logic;
		SD_CMD			: out			std_logic;
		
		-- Flash
		
		FL_ADDR        : out       std_logic_vector(21 downto 0);
		FL_CE_N        : out       std_logic_vector(0 downto 0);
		FL_OE_N        : out       std_logic_vector(0 downto 0);
		FL_DQ          : inout     std_logic_vector(7 downto 0);
		FL_RST_N       : out       std_logic_vector(0 downto 0);
		FL_WE_N        : out       std_logic_vector(0 downto 0);
		
		-- I2C 
		GPIO_0 : inout std_logic_vector(35 downto 0) := (others =>'X');
		GPIO_1 : inout std_logic_vector(35 downto 0) := (others =>'X')

);
end DrumAnywhere_1_0;


architecture structure of DrumAnywhere_1_0 is

	-- Declarations (optional)
	
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
				up_clocks_0_audio_clk_clk                        : out   std_logic;					-- clk				-- DACLRCK
				spi_0_external_MISO                              : in    std_logic                     := 'X';             -- MISO
            spi_0_external_MOSI                              : out   std_logic;                                        -- MOSI
            spi_0_external_SCLK                              : out   std_logic;                                        -- SCLK
            spi_0_external_SS_n                              : out   std_logic;                                        -- SS_n
				buttons_external_connection_export               : in    std_logic_vector(3 downto 0)  := (others => 'X');  -- export
				tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_read_n_out       : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_read_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_data_out         : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- generic_tristate_controller_0_tcm_data_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_chipselect_n_out : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_chipselect_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_write_n_out      : out   std_logic_vector(0 downto 0);                     -- generic_tristate_controller_0_tcm_write_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_address_out      : out   std_logic_vector(21 downto 0);                     -- generic_tristate_controller_0_tcm_address_out
				i2c_scl_external_connection_export                                               : out   std_logic;                                        -- export
            i2c_sda_external_connection_export                                               : inout std_logic                     := 'X';             -- export
            i2c_scl_2_external_connection_export                                             : out   std_logic;                                        -- export
            i2c_sda_2_external_connection_export                                             : inout std_logic                     := 'X';              -- export
				pio_0_external_connection_export                                                 : in    std_logic                     := 'X'              -- export
        );
    end component niosII_system;

--	These signals are for matching the provided IP core to
-- The specific SDRAM chip in our system	 
	 signal BA	: std_logic_vector (1 downto 0);
	 signal DQM	:	std_logic_vector (1 downto 0);
	 signal sys_clk : std_logic;
	 signal rst: std_LOGIC;
	 

begin

	DRAM_BA_1 <= BA(1);
	DRAM_BA_0 <= BA(0);
	
	DRAM_UDQM <= DQM(1);
	DRAM_LDQM <= DQM(0);
	
	FL_RST_N(0) <= '1';
	rst <= '1';
	
	-- Component Instantiation Statement (optional)
	
	  u0 : component niosII_system
        port map (
            clk_clk                                 => CLOCK_50,                                
            reset_reset_n                           => rst,                          
            sdram_0_wire_addr                       => DRAM_ADDR,                      
            sdram_0_wire_ba                         => BA,                        
            sdram_0_wire_cas_n                      => DRAM_CAS_N,                      
            sdram_0_wire_cke                        => DRAM_CKE,                       
            sdram_0_wire_cs_n                       => DRAM_CS_N,                      
            sdram_0_wire_dq                         => DRAM_DQ,                         
            sdram_0_wire_dqm                        => DQM,                        
            sdram_0_wire_ras_n                      => DRAM_RAS_N,                     
            sdram_0_wire_we_n                       => DRAM_WE_N,                       
            altpll_0_c0_clk                         => DRAM_CLK,                            
            sram_0_external_interface_DQ            => SRAM_DQ,           
            sram_0_external_interface_ADDR          => SRAM_ADDR,          
            sram_0_external_interface_LB_N          => SRAM_LB_N,         
            sram_0_external_interface_UB_N          => SRAM_UB_N,          
            sram_0_external_interface_CE_N          => SRAM_CE_N,         
            sram_0_external_interface_OE_N          => SRAM_OE_N,         
            sram_0_external_interface_WE_N          => SRAM_WE_N,          
            character_lcd_0_external_interface_DATA => LCD_DATA, 
            character_lcd_0_external_interface_ON   => LCD_ON,   
            character_lcd_0_external_interface_BLON => LCD_BLON, 
            character_lcd_0_external_interface_EN   => LCD_EN,   
            character_lcd_0_external_interface_RS   => LCD_RS,   
            character_lcd_0_external_interface_RW   => LCD_RW,
				clk_1_clk                                        => CLOCK_27,                                        --                                       clk_0.clk
            audio_and_video_config_0_external_interface_SDAT => I2C_SDAT, 							-- audio_and_video_config_0_external_interface.SDAT
            audio_and_video_config_0_external_interface_SCLK => I2C_SCLK, 							--                                            .SCLK
            audio_0_external_interface_ADCDAT                => AUD_ADCDAT,                --                  audio_0_external_interface.ADCDAT
            audio_0_external_interface_ADCLRCK               => AUD_ADCLRCK,               --                                            .ADCLRCK
            audio_0_external_interface_BCLK                  => AUD_BCLK,                  --                                            .BCLK
            audio_0_external_interface_DACDAT                => AUD_DACDAT,                --                                            .DACDAT
            audio_0_external_interface_DACLRCK               => AUD_DACLRCK,                --
				up_clocks_0_audio_clk_clk								 => AUD_XCK,
				spi_0_external_MISO                              => SD_DAT,                              --                              spi_0_external.MISO
            spi_0_external_MOSI                              => SD_CMD,                              --                                            .MOSI
            spi_0_external_SCLK                              => SD_CLK,                              --                                            .SCLK
            spi_0_external_SS_n                              => SD_DAT3, 
				buttons_external_connection_export               => KEY(3 downto 0),             --                 buttons_external_connection.export			--    
				tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_read_n_out       => FL_OE_N,    --               tristate_conduit_bridge_0_out.generic_tristate_controller_0_tcm_read_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_data_out         => FL_DQ,        --                                            .generic_tristate_controller_0_tcm_data_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_chipselect_n_out => FL_CE_N, --                                            .generic_tristate_controller_0_tcm_chipselect_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_write_n_out      => FL_WE_N,     --                                            .generic_tristate_controller_0_tcm_write_n_out
            tristate_conduit_bridge_0_out_generic_tristate_controller_0_tcm_address_out      => FL_ADDR,
				i2c_scl_external_connection_export                                               => GPIO_0(24),                                               --                 i2c_scl_external_connection.export
            i2c_sda_external_connection_export                                               => GPIO_0(25),                                               --                 i2c_sda_external_connection.export
            i2c_scl_2_external_connection_export                                             => GPIO_1(24),                                             --               i2c_scl_2_external_connection.export
            i2c_sda_2_external_connection_export                                             => GPIO_1(25),                                              --               i2c_sda_2_external_connection.export
				pio_0_external_connection_export                                                 => GPIO_1(17)             -- export
				
		);

end structure;


library ieee;

-- Commonly imported packages:

	-- STD_LOGIC and STD_LOGIC_VECTOR types, and relevant functions
	use ieee.std_logic_1164.all;

package DE2_CONSTANTS is
	
	type DE2_SDRAM_ADDR_BUS is array(11 downto 0) of std_logic;
	type DE2_SDRAM_DATA_BUS is array(15 downto 0) of std_logic;
	
	type DE2_LCD_DATA_BUS	is array(7 downto 0) of std_logic;
	
	type DE2_LED_GREEN		is array(7 downto 0)  of std_logic;
	
	type DE2_SRAM_ADDR_BUS	is array(17 downto 0) of std_logic;
	type DE2_SRAM_DATA_BUS  is array(15 downto 0) of std_logic;
	
end DE2_CONSTANTS;



