library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity uc is
	port (
		clock: in std_logic;
		carga, reset, pulso, pause: in std_logic;
		zera_quant, zera_prod: out std_logic;
		conta_quant, conta_prod: out std_logic;
		quant_fim, prod_fim: in std_logic;
		fim, avanco, inicia, interrompe: out std_logic
	);
end uc;

architecture arch_uc of uc is

	type tipo_estado is (inicial, resetcont, quant_count, quantcontando, prod_count, final);
	signal eatual, eprox: tipo_estado;

begin

	process(reset, clock, pause)
    begin
		if reset='1' then
            eatual<=inicial;
        elsif clock'event and clock='1' and pause='0' then
				eatual<=eprox;
        end if;
    end process;

	process(carga, pulso, eatual, prod_fim, quant_fim)
	begin
		
		case eatual is
			when inicial =>if carga = '1' then 
									eprox <= resetcont;
								end if;
								
			when resetcont => eprox <= quant_count;
								
			when quant_count => if quant_fim='0' then
											if pulso = '1' then
												eprox <= quantcontando;
											end if;
									   else eprox <= prod_count;
									   end if;
										if prod_fim='1' then
											eprox <= final;
										end if;
		
			when quantcontando => eprox <= quant_count;
											
			when prod_count =>	if prod_fim='0' then
											eprox <= quant_count;
										else
											eprox <= final;
										end if;
								
			when others =>		eprox <= inicial;
		end case;
								
	end process;
	
	with eatual select
		inicia <= '1' when resetcont, '0' when others;
	with eatual select
		zera_quant <= '1' when resetcont, '1' when prod_count, '0' when others;
	with eatual select
		zera_prod <= '1' when resetcont, '0' when others;
	conta_prod <='1' when eatual = prod_count and pause='0' else '0';
	conta_quant <= '1' when eatual=quantcontando and pause='0' else '0';
	with eatual select
		fim<='1' when final, '0' when others;
	with eatual select
		avanco<='1' when prod_count, '0' when others;
	with pause select
		interrompe<='1' when '1', '0' when others;
	

end arch_uc;