function [Axis,Angle]=RotVec_To_Axis_Angle(RotVec)


%%HELP
% Input an Rotation Vector to change it into rotation Rotation Vector 
% Rotation vector must be 1x3.

disp ('Rotation Vector to euler axis angle')
Angle = norm(RotVec)
Axis = RotVec/Angle

end