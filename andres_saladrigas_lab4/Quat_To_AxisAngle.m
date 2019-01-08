function [Axis,Angle] = Quat_To_AxisAngle(quat)
%%HELP
% introduce a Euler axis angle and get a quaterinipon
% angle in radians and axis in size 1x3 
%% reshape
disp (' from quat to axis angle ')
Angle = 2*acos(quat(1,1))

quat_vec = [quat(1,2) quat(1,3) quat(1,4)]
Axis = quat_vec / (sin(Angle/2))
if Angle ==0
    disp('angle of rotation is 0')
end
end