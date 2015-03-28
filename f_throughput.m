function func = f_throughput( p_ber,mac_ovh,phy_ovh,tdd,frame_size )

%   returns the normalized value for throughput
func = (frame_size/(frame_size+phy_ovh+mac_ovh))*((1-p_ber).^(frame_size+mac_ovh))*tdd;
end
