library IEEE;

use IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;
use WORK.constants.all;
use WORK.alu_type.all;

entity TBALU is
end TBALU;

architecture TEST of TBALU is
    constant NBIT: integer := 16;
	signal	FUNC_CODE:	TYPE_OP:=ADD;
	signal	OP1:	STD_LOGIC_VECTOR(NBIT-1 downto 0);
	signal	OP2:	STD_LOGIC_VECTOR(NBIT-1 downto 0);
	signal	RESULT:	STD_LOGIC_VECTOR(NBIT-1 downto 0);
	
	component ALU
            generic (N : integer := numBit);
            port 	 ( FUNC: IN TYPE_OP;
                           DATA1, DATA2: IN std_logic_vector(N-1 downto 0);
                          OUTALU: OUT std_logic_vector(N-1 downto 0));
	end component;

begin 
		
	U1 : ALU
	Generic Map (NBIT)
	Port Map (FUNC_CODE, OP1, OP2,  RESULT); 


--	OP1 <= ('0',others => '1') after 0.5 ns, ('1',others => '0') after 3 ns,('0','0','0',others => '1') after 6 ns,('0',others => '1')
--	after 9 ns,('1',others => '0') after 12 ns,('0','0','0',others => '1') after 15 ns;

--	OP2 <= ('0',others => '1') after 0.5 ns, ('1',others => '0') after 3 ns,('0','0','0',others => '1') after 6 ns,('0',others => '1')
--	after 9 ns,('1',others => '0') after 12 ns,('0','0','0',others => '1') after 15 ns;

        OP1 <= "0000000000110101";
        OP2 <= "0000000000010110";
		--OP1	<= "1111"; --15
		--OP2 <= "0110"; --6
FUNC_CODE <= 	ADD after 2 ns, 		--0101
		     	SUB after 4 ns,			--1001
	            MULT after 6 ns,		--0110
				BITAND after 8 ns,		--0110
	            BITOR after 10 ns,		--1111
				BITXOR after 12 ns,		--1001
	            FUNCRL after 14 ns,		--1111		rotate left
				FUNCRR after 16 ns,		--1111		rotate right  
	            FUNCLSL after 18 ns,	--1110
				FUNCLSR after 20 ns;	--0111
	             

end TEST;

configuration ALU_TEST of TBALU is
   for TEST
      for U1: ALU
         use configuration WORK.CFG_ALU_BEHAVIORAL; 
      end for;
	
   end for;
end ALU_TEST;

