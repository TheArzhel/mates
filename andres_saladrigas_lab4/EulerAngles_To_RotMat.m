function RotMat=EulerAngles_To_RotMat(Pitch,Roll,Yaw)

%%HELP
% Enter Euler Angles and transform it to Rotation Matrix
% Angles MUST be in radians

RotMat=[0 0 0; 0 0 0; 0 0 0];

if (Pitch<=2*pi||Roll<=2*pi||Yaw<=2*pi)
    a=(cos(Pitch)*cos(Yaw));

    b=(cos(Yaw)*sin(Pitch)*sin(Roll)-cos(Roll)*sin(Yaw));

    c=(cos(Yaw)*cos(Yaw)*sin(Pitch)+sin(Yaw)*sin(Roll));

    d= (cos(Pitch)*sin(Yaw));

    e= (sin(Yaw)*sin(Pitch)*sin(Roll)+cos(Roll)*cos(Yaw));

    f= (sin(Yaw)*sin(Yaw)*cos(Pitch)-cos(Yaw)*sin(Roll));

    g=-sin(Pitch);

    h= cos(Pitch)*sin(Roll);

    i=  cos(Pitch)*cos(Roll);

    disp (' from euler angles to rotation matrix')
    RotMat = [a b c; d e f; g h i]
    
else
    
   disp('angles must be bellow 2pi')

end

end