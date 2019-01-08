function [Axis,Angle]=RotMat_To_AxisAngle(RotMat)

%%HELP
% Enter a Rotation Matrix and transform it to Euler Axis Angle
% Rotation matrix is 3x3

Axis=[ 0 0 0];
Angle=0;
if det(RotMat)<1.0001 && det(RotMat)>0.9
    disp ('rotation matrix to axis angle')
    Angle = acos((trace(RotMat)-1)/2)
    CrossPMAtrix = (RotMat-RotMat')/(2*sin(Angle));
    Axis = [CrossPMAtrix(3,2) CrossPMAtrix(1,3) CrossPMAtrix(2,1)]
    
    if Angle == 0
        disp('no rotation, could give error')
else 
    disp('rotmatrix must have determinat equal to 1')
end
end