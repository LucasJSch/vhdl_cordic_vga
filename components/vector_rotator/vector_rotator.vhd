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
        -- 2**(N_BITS_VECTOR-2) -->  1
        -- 2**(N_BITS_VECTOR-1) --> -1
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
        xout  : out signed(N_BITS_VECTOR downto 0);
        yout  : out signed(N_BITS_VECTOR downto 0);
        zout  : out signed(N_BITS_VECTOR downto 0);
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

    function signed_mul(a : signed(N_BITS_VECTOR downto 0); b : signed(N_BITS_VECTOR-1 downto 0))
    return signed is
        variable sign_bit : std_logic;
        variable retval   : signed(N_BITS_VECTOR downto 0);
        variable aux_mul  : signed(N_BITS_VECTOR*2 downto 0);
    begin
        aux_mul := a * b;
        if (a(a'length-1) = '0' and b(b'length-1) = '0') or (a(a'length-1) = '1' and b(b'length-1) = '1') then
            sign_bit := '0';
        else
            sign_bit := '1';
        end if;
        retval := sign_bit & aux_mul((N_BITS_VECTOR*2)-2 downto N_BITS_VECTOR-1);
        return retval;
    end signed_mul;

    function get_shifted_vector(a : signed(N_BITS_VECTOR downto 0))
    return signed is
    begin
        return a(a'length-2 downto 0);
    end get_shifted_vector;

	constant N_ITER         : integer := 15;
    -- 1/1.64 = 0.6097 --> CORDIC scaling factor.
    constant CORDIC_SCALING : signed(N_BITS_VECTOR-1 downto 0) := to_signed(integer((2**(N_BITS_VECTOR-1)) * 0.6097), N_BITS_VECTOR);

    -- Start states: Initializes variables to start processing
    -- Processing states: Checks if the processing is done
                    -- TODO: Add uninitialized_state logic to avoid computing when starting the simulation.
	type state_t is (--uninitialized_state,
                     start_state,
                     alpha_start_state,
                     alpha_processing_state,
                     beta_start_state,
                     beta_processing_state,
                     gamma_start_state,
                     gamma_processing_state,
                     done_state);
    signal current_state : state_t := start_state;

    signal start_cordic : std_logic := '0';
    -- Used to not depend on rising_edge of start_cordic, but also not depend only on current state of start_cordic.
    -- I.e. only depend on if start_cordic w.r.t. previous clock signal.
    signal start_history : std_logic := '0';
    signal done_cordic  : std_logic := '0';
    signal angle_cordic : signed(N_BITS_ANGLE-1 downto 0);
    signal xin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal yin_cordic   : signed(N_BITS_VECTOR-1 downto 0) := (others => '0');
    signal xout_cordic  : signed(N_BITS_VECTOR downto 0);
    signal yout_cordic  : signed(N_BITS_VECTOR downto 0);

    signal x1           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal y1           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal z1           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal x2           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal y2           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal z2           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal x3           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal y3           : signed(N_BITS_VECTOR downto 0) := (others => '0');
    signal z3           : signed(N_BITS_VECTOR downto 0) := (others => '0');

    signal processing : std_logic := '0';

begin

        process(clk, start)
        begin
            if rising_edge(clk) then
                if start = '1' and start_history = '0' then
                    current_state <= start_state;
                    start_history <= '1';
                elsif start = '0' and start_history='1' then
                    start_history <= '0';
                else
                    case current_state is
                        when start_state =>
                            start_cordic <= '0';
                            processing <= '0';
                            done <= '0';
                            current_state <= gamma_start_state;

                        -- Gamma states
                        when gamma_start_state =>
                            processing <= '1';
                            start_cordic <= '1';
                            xin_cordic <= xin;
                            yin_cordic <= yin;
                            angle_cordic <= gamma;
                            current_state <= gamma_processing_state;
                        when gamma_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= beta_start_state;
                                -- TODO: Asumo zin positivo. Contemplar otros casos.
                                x1 <= signed_mul(xout_cordic, CORDIC_SCALING);
                                y1 <= signed_mul(yout_cordic, CORDIC_SCALING);
                                z1 <= '0' & zin;
                            end if;

                        -- Beta states
                        when beta_start_state =>
                            xin_cordic <= get_shifted_vector(z1);
                            yin_cordic <= get_shifted_vector(x1);
                            angle_cordic <= beta;
                            start_cordic <= '1';
                            current_state <= beta_processing_state;
                        when beta_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= alpha_start_state;
                                x2 <= signed_mul(yout_cordic, CORDIC_SCALING);
                                y2 <= y1;
                                z2 <= signed_mul(xout_cordic, CORDIC_SCALING);
                            end if;
                        
                        -- Alpha states
                        when alpha_start_state =>
                            xin_cordic <= get_shifted_vector(y2);
                            yin_cordic <= get_shifted_vector(z2);
                            angle_cordic <= alpha;
                            start_cordic <= '1';
                            current_state <= alpha_processing_state;
                        when alpha_processing_state =>
                            start_cordic <= '0';
                            if done_cordic = '1' then
                                current_state <= done_state;
                                x3 <= x2;
                                y3 <= signed_mul(xout_cordic, CORDIC_SCALING);
                                z3 <= signed_mul(yout_cordic, CORDIC_SCALING);
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

        process(x3, y3, z3)
        begin
            xout <= x3;
            yout <= y3;
            zout <= z3;
        end process;
end;
