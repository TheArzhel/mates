function [Pitch,Roll,Yaw]=RotMat_To_EulerAngles(RotMat)

%%HELP
% Enter a Rotation Matrix and transform it to Euler Angles
% Rotation matrix is 3x3

  Pitch = 0;
  Roll = 0;
  Yaw = 0;
  
  
if (det(RotMat)<1.0001 && det(RotMat)>0.9)
    
    disp('from rotation matrix to euler angles')
    
    Pitch = asin(-RotMat(3,1))
    Roll = atan2(RotMat(3,2)/cos(Pitch),RotMat(3,3)/cos(Pitch))
    Yaw = atan2(RotMat(2,1)/cos(Pitch),RotMat(1,1)/cos(Pitch))
    
else
    disp('RotMatrix must have determinant equal to 1')
    
end

end