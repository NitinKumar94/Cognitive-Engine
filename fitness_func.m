function func = fitness_func( chromosome )

%   returns the fitness value for the all corresponding objective functions

%%weight vectors for emergency mode operation (minimizing BER)
w1 = 0.55;
w2 = 0.15;
w3 = 0.15;
w4 = 0.15;

%%Constant values for environment parameters. Will make this value dynamic
%%from a set of computed values based on other environment parameters
p_ber = 0.0175;

%%Constant values of transmission parameters
phy_ovh = 52.5;
mac_ovh = 40;

%%Maximum and minimum values for transmission parameters
power_max = 24; %maximum power in dB
power_min = -8; %minimum power in dB
bandwidth_max = 32; %maximum bandwidth in Hz
bandwidth_min = 2;  %minimum bandwidth in Hz
tdd_min = 25;   %minimum time for transmitting
tdd_max = 100;  %maximum time for transmitting

%%Transmission parameter ranges
power_list = (power_min:2:power_max);
bandwidth_list = (bandwidth_min:2:bandwidth_max);
frame_list = (100:100:1600);
tdd_list = (tdd_min:25:tdd_max);

pow = power_list(bi2de(chromosome(1:4),'left-msb')+1);
band = bandwidth_list(bi2de(chromosome(5:8),'left-msb')+1);
frame = frame_list(bi2de(chromosome(9:12),'left-msb')+1);
tdd = tdd_list(bi2de(chromosome(13:14),'left-msb')+1);

func = w1*f_ber(p_ber) + w2*f_int(pow,band,tdd, power_min,power_max,bandwidth_min,bandwidth_max) + w3*f_power(pow,band,power_max,bandwidth_max) + w4*f_throughput(p_ber,mac_ovh,phy_ovh,tdd,frame);

end

