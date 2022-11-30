%% Optimization Script
% housekeeping
clc; clear; close all;
% initialize
Passed_configs = zeros(1,5);
Bat_Remainder_percent = zeros(1,2);
Payload = 35; %lbs
count = 1;
best = [];
t = 0;
Distance = 12; %distance in miles
% loop
for i = 1:10
    for j = 1:15
        for k = 1:3
            % inputs
            D = James_MotorCombo(i);
            B = BatteryInfo(j);
            % checks to make
            [CurrentCheck, ThrustCheck, TDF] = Current_thrust_Check(D,B,Payload,k);
            % Tracking 
            if (CurrentCheck == 1 && ThrustCheck == 1)
                % Run the mission sim
                [Mission_Check, Bat_Remainder] = MissionSim(D, B, Payload, Distance, TDF);
                if (Mission_Check == 1)
                    t = t+1;
                    Bat_Remainder_percent(t,:) = [t, (Bat_Remainder/str2double(B.Battery_Cap_mAH)*100)];
                    Passed_configs(t,:) = [t,i,j,k, Bat_Remainder];
                end
            end
        end 
    end
end
disp(Passed_configs)
% find best run
[BRP,I] = max(Bat_Remainder_percent(:,2));
best = Passed_configs(I,2:4);
best_percent = num2str(BRP) + "%";
format shortG
fprintf('Best run configuration is [')
fprintf('%g, ',best(1:end-1));
fprintf('%g]\nwith %s Battery Remaining\n', best(end),best_percent)