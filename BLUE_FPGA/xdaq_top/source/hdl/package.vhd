library ieee;
use ieee.std_logic_1164.all;

package xpackage is
    type array16 is array(integer range<>) of std_logic_vector(15 downto 0);
    type array32 is array(integer range<>) of std_logic_vector(31 downto 0);
    type array64 is array(integer range<>) of std_logic_vector(63 downto 0);
--    type array_2d is array(integer range<>) of std_logic_vector;
--    type mem_t is array(integer range<>) of array_2d;
end package;

