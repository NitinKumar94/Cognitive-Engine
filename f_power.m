function func = f_power( pow,band,power_max,bandwidth_max )

%   returns the normalized value for interference
func = 1 - ((power_max - pow + bandwidth_max - band)/(power_max + bandwidth_max));
end

