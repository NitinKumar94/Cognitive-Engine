%%This file calculates the global optimum values for transmission parameters using brute force search

%%weight vectors for emergeny mode operation (minimizing BER)
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
bandwidth_max = 32; %maximum bandwith in Hz
bandwidth_min = 2;  %minimum bandwidth in Hz
tdd_min = 25;   %minimum time for transmitting
tdd_max = 100;  %maximum time for transmitting

%%Transmission parameter ranges
power_list = (power_min:2:power_max);
bandwidth_list = (bandwidth_min:2:bandwidth_max);
frame_list = (100:100:1600);
tdd_list = (tdd_min:25:tdd_max);

idx = 1;

for itr_p=1:16
    for itr_b=1:16
        for itr_f=1:16
            for itr_tdd=1:4
                fitness_score(idx) = w1*f_ber(p_ber) + w2*f_int(power_list(itr_p),bandwidth_list(itr_b),tdd_list(itr_tdd), power_min,power_max,bandwidth_min,bandwidth_max) + w3*f_power(power_list(itr_p),bandwidth_list(itr_b),power_max,bandwidth_max) + w4*f_throughput(p_ber,mac_ovh,phy_ovh,tdd_list(itr_tdd),frame_list(itr_f)); 
                   idx=idx+1;
            end %itr_tdd
        end %itr_f
    end %itr_b
end %itr_p

message1 = ['Number of combinations explored = ',num2str(length(fitness_score))];
message2 = ['Maximum value of fitness score = ',num2str(max(fitness_score))];
disp(message1);
disp(message2);
