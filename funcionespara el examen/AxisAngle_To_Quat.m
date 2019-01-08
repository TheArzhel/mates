function Quat=AxisAngle_To_Quat(Axis,Angle)

%%HELP
%Input an euler axis and a euler angle to change it into quaternion
%First argument must be euler axis, second angle. Axis must be normalized and angle must be in radians

Quat=[0 0 0 0];



if norm(Axis)<1.0001 && norm(Axis)>0.9
    
    disp ('euler axis angle to quat')
    Quat=[cos(Angle/2) Axis*sin(Angle/2)]
    
else 
    disp('Axis must be normalized')
    disp ('normalizing')
    Axis=Axis/norm(Axis)
    disp ('euler axis angle to quat')
    Quat=[cos(Angle/2) Axis*sin(Angle/2)]
end

end