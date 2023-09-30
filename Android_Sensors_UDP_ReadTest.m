clear all
close all
clc

u1 = udpport("LocalPort",25000);

cnt = 0;
Acc_hist = zeros(3,1000);
while(1)
    cnt = cnt + 1;
    rvc_buff = read(u1,80);
    if(length(rvc_buff)==80)
        Lat = typecast(uint8(rvc_buff(1:4)), 'single');
        Lon = typecast(uint8(rvc_buff(5:8)), 'single');
        Alt = typecast(uint8(rvc_buff(9:12)), 'single');

        temp = typecast(uint8(rvc_buff(13:16)), 'single');
        press = typecast(uint8(rvc_buff(17:20)), 'single');

        Gx = typecast(uint8(rvc_buff(21:24)), 'single');
        Gy = typecast(uint8(rvc_buff(25:28)), 'single');
        Gz = typecast(uint8(rvc_buff(29:32)), 'single');
        
        Or_x = typecast(uint8(rvc_buff(33:36)), 'single')*pi/180;
        Or_y = typecast(uint8(rvc_buff(37:40)), 'single')*pi/180;
        Or_z = typecast(uint8(rvc_buff(41:44)), 'single')*pi/180;

        Acc_x = typecast(uint8(rvc_buff(45:48)), 'single');
        Acc_y = typecast(uint8(rvc_buff(49:52)), 'single');
        Acc_z = typecast(uint8(rvc_buff(53:56)), 'single');

        Mag_x = typecast(uint8(rvc_buff(57:60)), 'single');
        Mag_y = typecast(uint8(rvc_buff(61:64)), 'single');
        Mag_z = typecast(uint8(rvc_buff(65:68)), 'single');

        humid = typecast(uint8(rvc_buff(69:72)), 'single');
        light = typecast(uint8(rvc_buff(73:76)), 'single');
        counter = typecast(uint8(rvc_buff(77:80)), 'single');
        
        Acc_hist = circshift(Acc_hist,1,2);
        Acc_hist(1,end) = Acc_x;
        Acc_hist(2,end) = Acc_y;
        Acc_hist(3,end) = Acc_z;
        if(rem(cnt,10)==1)
            fprintf('\rACC: %2.2f, %2.2f, %2.2f, Lat-Lon: %2.2f, %2.2f',Acc_x, Acc_y, Acc_z, Lat, Lon);
            subplot(3,1,1)
            plot(Acc_hist(1,:))
            subplot(3,1,2)
            plot(Acc_hist(2,:))
            subplot(3,1,3)
            plot(Acc_hist(3,:))
            drawnow
        end
    end
end
