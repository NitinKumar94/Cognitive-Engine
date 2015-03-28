function func = f_ber( p_ber )

%   This function returns the normalized value for p_ber
func = 1 - (log10(0.5)/log10(p_ber));
end

