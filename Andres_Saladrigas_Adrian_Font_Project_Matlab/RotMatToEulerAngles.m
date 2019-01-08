function [Roll,Pitch,Yaw]=RotMatToEulerAngles(RotMat)
%INPUT:RotMat
%OUTPUT:Pitch,Roll,Yaw

% roll = z
% pìtch = Y
% yaw = x

Pitch=0;
Roll=0;
Yaw=0;

if det(RotMat)<1.0001 && det(RotMat)>0.9

Pitch=asin(-RotMat(3,1));
Roll=atan2(RotMat(3,2)/cos(Pitch),RotMat(3,3)/cos(Pitch));
Yaw=atan2(RotMat(2,1)/cos(Pitch),RotMat(1,1)/cos(Pitch));
%disp("Success");

else
   disp("determinant of RotMAt not equal to one"); 
    
end

% disp("Euler Angles:")
% disp("")
% disp("y Pitch:");
% disp(Pitch);
% disp("z Roll:");
% disp(Roll);
% disp("x Yaw:");
% disp(Yaw);

end