function RotVec=AxisAngle_To_RotationVec(Axis,Angle)

%%HELP
%Input an euler axis and a euler angle to change it into rotation vector
%First argument must be euler axis, second angle. Axis must be normalized and angle must be in radians

RotVec=[0 0 0];

if norm(Axis)<1.0001 && norm(Axis)>0.9
    
    disp (' Euler axis angle to rotation ')
    RotVec = Angle*Axis

else 
    disp('Axis must be normalized')
    
end