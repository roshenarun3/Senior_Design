%% Optimization Script
%% housekeeping
clc; clear; close all;
% initialize
Passed_configs = zeros(1,4);
Payload = 55; %lbs
count = 1;
t = 0;
Distance = 16; %distance in miles
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
                %% Run the mission sim
                [Mission_Check, Bat_Remainder] = MissionSim(D, B, Payload, Distance, TDF);
                if (Mission_Check == 1)
                    t = t+1;
                    Passed_configs(t,:) = [t,i,j,k];
                end
            end
        end 
    end
end
disp(Passed_configs)