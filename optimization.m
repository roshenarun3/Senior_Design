%% Optimization Script
% housekeeping
clc; clear; close all;
% initialize
Passed_configs = zeros(1,6);
Bat_Remainder_percent = [];
Payload = 26; %lbs
count = 1;
best = [];
t = 0;
Distance = 16; %distance in miles
% loop
for i = 1:10
    D = James_MotorCombo(i);
    for j = 1:15
        B = BatteryInfo(j);
        for k = 1:3
            % checks
            [CurrentCheck, ThrustCheck, TDF] = Current_thrust_Check(D,B,Payload,k);
            % Tracking 
            if (CurrentCheck == 1 && ThrustCheck == 1)
                % Run the mission sim
                [Mission_Check, Bat_Remainder] = MissionSim(D, B, Payload, Distance, TDF);
                if (Mission_Check == 1)
                    t = t+1;
                    Bat_Remainder_percent = (Bat_Remainder/str2double(B.Battery_Cap_mAH)*100);
                    Passed_configs(t,:) = [i,j,k, Bat_Remainder, Bat_Remainder_percent, Payload];
                end
            end
        end 
    end
end
%% find best run
format shortG
disp(Passed_configs)
% find best run
[BRP,I] = max(Passed_configs(:,5));
best = Passed_configs(I,:);
best_percent = num2str(BRP) + "%";
format shortG
fprintf('Best run configuration is [')
fprintf('%g, ',best(1:end-1));
fprintf('%g]\nwith %s Battery Remaining\n', best(end),best_percent)