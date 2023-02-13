library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Angle calculator, based on two pulsator.
-- There's one pulsator for positive angles, and one for negatives.
-- When p(0) is pulsated, ANGLE_DIFF is added to the accumulated angle.
-- When p(1) is pulsated, ANGLE_DIFF is substracted to the accumulated angle.
entity vector_rotator is
    generic(
        -- Describes the amount of bits per vector element.
        N_BITS_VECTOR : integer:= 32;
        -- Describes the amount of bits to represent the angle.
        N_BITS_ANGLE : integer := 17);
    port(
        -- 2**(N_BITS_VECTOR-1) -->  1
        -- 2**(N_BITS_VECTOR)-1 --> -1
        -- 2**(N_BITS_ANGLE-1) --> 180
        -- 2**(N_BITS_ANGLE-2) --> 90
        -- 2**(N_BITS_ANGLE-3) --> 45
        clk   : in std_logic;
        xin   : in signed(N_BITS_VECTOR-1 downto 0);
        yin   : in signed(N_BITS_VECTOR-1 downto 0);
        zin   : in signed(N_BITS_VECTOR-1 downto 0);
        alpha : in signed(N_BITS_ANGLE-1 downto 0);
        beta  : in signed(N_BITS_ANGLE-1 downto 0);
        gamma : in signed(N_BITS_ANGLE-1 downto 0);
        start : in std_logic;
        xout  : out signed(N_BITS_VECTOR-1 downto 0);
        yout  : out signed(N_BITS_VECTOR-1 downto 0);
        zout  : out signed(N_BITS_VECTOR-1 downto 0);
        done  : out std_logic);

end;

architecture vector_rotator_arch of vector_rotator is

    component cordic is
        generic(
            -- Describes the amount of bits per vector element.
            N_BITS_VECTOR : integer:= 32;
            -- Describes the amount of bits to represent the angle.
            N_BITS_ANGLE : integer := 18;
            N_ITER       : integer := 15);
        port(
            clk  : in std_logic;
            x1   : in std_logic_vector(N_BITS_VECTOR-1 downto 0);
            y1   : in std_logic_vector(N_BITS_VECTOR-1 downto 0);
            beta : in signed(N_BITS_ANGLE-1 downto 0);
            start: in std_logic;
            x2   : out std_logic_vector(N_BITS_VECTOR downto 0);
            y2   : out std_logic_vector(N_BITS_VECTOR downto 0);
            z2   : out std_logic_vector(N_BITS_ANGLE-1 downto 0);
            done : out std_logic);
    end component;

	constant N_ITER        : integer := 15;

    -- Start states: Initializes variables to start processing
    -- Processing states: Checks if the processing is done
	type state_t is (start_state,
                     alpha_start_state,
                     alpha_processing_state,
                     beta_start_state,
                     beta_processing_state,
                     gamma_start_state,
                     gamma_processing_state,
                     done_state);
    signal current_state : state_t := start_state;

    signal start_cordic : std_logic := '0';
    signal done_cordic  : std_logic := '0';
    signal angle_cordic : signed(N_BITS_ANGLE-1 downto 0);
    signal xin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal yin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal xout_cordic  : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal yout_cordic  : signed(N_BITS_VECTOR downto 0) := (others => '0');

    signal x1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal x2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal x3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');

    signal processing : std_logic := '0';

    signal debug : std_logic_vector(2 downto 0) := (others => '0');

begin

        -- TODO: Normalizar vectores post-cordic
        process(clk, start)
        begin
            if rising_edge(clk) then
                if start = '1' then
                    current_state <= start_state;
                else
                    case current_state is
                        when start_state =>
                            start_cordic <= '0';
                            processing <= '0';
                            done <= '0';
                            current_state <= alpha_start_state;
                            debug <= "001";

                        -- Alpha states
                        when alpha_start_state =>
                            processing <= '1';
                            start_cordic <= '1';
                            xin_cordic <= yin;
                            yin_cordic <= zin;
                            angle_cordic <= alpha;
                            current_state <= alpha_processing_state;
                            debug <= "010";
                        when alpha_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= beta_start_state;
                                debug <= "011";
                                x1 <= xin;
                                y1 <= xout_cordic(N_BITS_VECTOR-1 downto 0);
                                z1 <= yout_cordic(N_BITS_VECTOR-1 downto 0);
                            end if;

                        -- Beta states
                        when beta_start_state =>
                            xin_cordic <= x1;
                            yin_cordic <= z1;
                            angle_cordic <= beta;
                            start_cordic <= '1';
                            current_state <= beta_processing_state;
                            debug <= "100";
                        when beta_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= gamma_start_state;
                                debug <= "101";
                                x2 <= xout_cordic(N_BITS_VECTOR-1 downto 0);
                                y2 <= y1;
                                z2 <= yout_cordic(N_BITS_VECTOR-1 downto 0);
                            end if;
                        
                        -- Gamma states
                        when gamma_start_state =>
                            xin_cordic <= x2;
                            yin_cordic <= y2;
                            angle_cordic <= gamma;
                            start_cordic <= '1';
                            current_state <= gamma_processing_state;
                            debug <= "110";
                        when gamma_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= done_state;
                                debug <= "111";
                                x3 <= xout_cordic(N_BITS_VECTOR-1 downto 0);
                                y3 <= yout_cordic(N_BITS_VECTOR-1 downto 0);
                                z3 <= z2;
                            end if;

                        when done_state =>
                            done <= '1';
                            processing <= '0';
                    end case;
                end if;
            end if;
        end process;

    	cordic_machine: cordic
		generic map(N_BITS_VECTOR, N_BITS_ANGLE, N_ITER)
		port map(
            clk   => clk,
            x1    => std_logic_vector(xin_cordic),
            y1    => std_logic_vector(yin_cordic),
            beta  => angle_cordic,
            start => start_cordic,
            signed(x2)    => xout_cordic,
            signed(y2)    => yout_cordic,
            done  => done_cordic);

        xout <= x3;
        yout <= y3;
        zout <= z3;
end;
