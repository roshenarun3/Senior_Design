%% Optimization Script
%% housekeeping
clc; clear; close all;
% initialize
Passed_configs = zeros(1,4);
Payload = 25; %lbs
count = 1;
t = 0;
%% loop
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
                t = t+1;
                Passed_configs(t,:) = [t,i,j,k];
            end
            count = count + 1;
            % ahere
            
        end 
    end
end
disp(Passed_configs)