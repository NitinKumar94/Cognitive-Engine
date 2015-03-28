function func = f_int( pow,band,tdd, power_min,power_max,bandwidth_min,bandwidth_max)

%   returns the normalized value for f_int
func = 1 - (((pow*band*tdd) - (power_min*bandwidth_min))/(power_max*bandwidth_max*100));
end

