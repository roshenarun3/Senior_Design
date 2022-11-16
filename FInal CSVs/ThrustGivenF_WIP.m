function [outputArg1,outputArg2] = ThrustGivenF(D,F)
% Function Description
% Takes in a struct containing info on a motor and prop "D", and a force
% "F" and outputs the throttle required to maintian equilibrium

% Variables
% F = total Down force

% Constants
numMotors = 8;

req_motor_thrust = F/numMotors;
thrustvec = D.Thrust_g
end