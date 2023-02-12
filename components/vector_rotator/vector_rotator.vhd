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
        x0    : in signed(N_BITS_VECTOR-1 downto 0);
        y0    : in signed(N_BITS_VECTOR-1 downto 0);
        z0    : in signed(N_BITS_VECTOR-1 downto 0);
        alpha : in signed(N_BITS_ANGLE-1 downto 0);
        beta  : in signed(N_BITS_ANGLE-1 downto 0);
        gamma : in signed(N_BITS_ANGLE-1 downto 0);
        start : in std_logic;
        done  : out std_logic);

end;

architecture vector_rotator_arch of vector_rotator is
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
    signal current_state : state_t;

    signal start_cordic : std_logic := '0';
    signal done_cordic  : std_logic := '0';
    signal angle_cordic : signed(N_BITS_ANGLE-1 downto 0);
    signal xin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal yin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal xout_cordic  :  signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal yout_cordic  : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');

    signal x1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z1           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal x2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z2           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal x3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal y3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal z3           : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');

    signal processing : std_logic = '0';

begin
        process(start)
        begin
            current_state <= start_state;
        end process;

        -- TODO: Normalizar vectores post-cordic
        process(clk)
        begin
            if rising_edge(clk)
                case current_state is
                    when start_state =>
                        start_cordic <= '0';
                        alpha_done <= '0';
                        beta_done <= '0';
                        gamma_done <= '0';
                        processing <= '0';
                        done <= '0';
                        current_state <= alpha_start_state;

                    when alpha_start_state =>
                        processing <= '1';
                        start_cordic <= '1';
                        xin_cordic <= y0;
                        yin_cordic <= z0;
                        angle_cordic <= alpha;
                        current_state <= alpha_processing_state;
                    when alpha_processing_state =>
                        start_cordic <= '0';
                        if rising_edge(cordic_done)
                            current_state <= beta_start_state;
                            x1 <= x0;
                            y1 <= xout_cordic;
                            z1 <= yout_cordic;
                        end if;

                    when beta_start_state =>
                        x1_cordic <= x1_cordic;
                        y1_cordic <= z1_cordic;
                        angle_cordic <= beta;
                        start_cordic <= '1';
                        current_state <= beta_processing_state;
                    when beta_processing_state =>
                        start_cordic <= '0';
                        if rising_edge(cordic_done)
                            current_state <= gamma_start_state;
                            x2 <= xout_cordic;
                            y2 <= y1;
                            z2 <= yout_cordic;
                        end if;
                    
                    when gamma_start_state =>
                        x1_cordic <= x2_cordic;
                        y1_cordic <= y2_cordic;
                        angle_cordic <= gamma;
                        start_cordic <= '1';
                        current_state <= gamma_processing_state;
                    when gamma_processing_state =>
                        start_cordic <= '0';
                        if rising_edge(cordic_done)
                            current_state <= done_state;
                            x3 <= xout_cordic;
                            y3 <= yout_cordic;
                            z3 <= z2;
                        end if;

                    when done_state =>
                        done <= '1';
                        processing <= '0';
                end case;
            end if;
        end process;

    	cordic_machine: cordic
		generic map(N_BITS_VECTOR, N_BITS_ANGLE, N_ITER)
		port map(
            clk   => clk,
            x1    => xin_cordic,
            y1    => yin_cordic,
            beta  => angle_cordic,
            start => start_cordic,
            x2    => xout_cordic,
            y2    => yout_cordic,
            done  => done_cordic);
end;
