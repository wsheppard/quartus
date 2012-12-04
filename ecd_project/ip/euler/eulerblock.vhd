-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 12.1 Build 177 11/07/2012 SJ Web Edition"
-- CREATED		"Fri Nov 30 15:38:43 2012"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY eulerblock IS 
	PORT
	(
		sys_clk :  IN  STD_LOGIC;
		s1_reset :  IN  STD_LOGIC;
		s1_read :  IN  STD_LOGIC;
		s1_write :  IN  STD_LOGIC;
		s1_address :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		s1_writedata :  IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
		s1_readdata :  OUT  STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END eulerblock;

ARCHITECTURE bdf_type OF eulerblock IS 

COMPONENT altfp_exp0
	PORT(clock : IN STD_LOGIC;
		 clk_en : IN STD_LOGIC;
		 data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 nan : OUT STD_LOGIC;
		 overflow : OUT STD_LOGIC;
		 underflow : OUT STD_LOGIC;
		 zero : OUT STD_LOGIC;
		 result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

COMPONENT euler_control
	PORT(s1_clk : IN STD_LOGIC;
		 s1_reset : IN STD_LOGIC;
		 s1_read : IN STD_LOGIC;
		 s1_write : IN STD_LOGIC;
		 euler_status : IN STD_LOGIC;
		 euler_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 s1_address : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		 s1_writedata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		 euler_enable : OUT STD_LOGIC;
		 euler_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
		 s1_readdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_4 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_5 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_6 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_7 :  STD_LOGIC;


BEGIN 



b2v_inst : altfp_exp0
PORT MAP(clock => sys_clk,
		 clk_en => SYNTHESIZED_WIRE_0,
		 data => SYNTHESIZED_WIRE_1,
		 nan => SYNTHESIZED_WIRE_4,
		 overflow => SYNTHESIZED_WIRE_7,
		 underflow => SYNTHESIZED_WIRE_5,
		 zero => SYNTHESIZED_WIRE_6,
		 result => SYNTHESIZED_WIRE_3);


b2v_inst1 : euler_control
PORT MAP(s1_clk => sys_clk,
		 s1_reset => s1_reset,
		 s1_read => s1_read,
		 s1_write => s1_write,
		 euler_status => SYNTHESIZED_WIRE_2,
		 euler_in => SYNTHESIZED_WIRE_3,
		 s1_address => s1_address,
		 s1_writedata => s1_writedata,
		 euler_enable => SYNTHESIZED_WIRE_0,
		 euler_out => SYNTHESIZED_WIRE_1,
		 s1_readdata => s1_readdata);


SYNTHESIZED_WIRE_2 <= SYNTHESIZED_WIRE_4 OR SYNTHESIZED_WIRE_5 OR SYNTHESIZED_WIRE_6 OR SYNTHESIZED_WIRE_7;


END bdf_type;