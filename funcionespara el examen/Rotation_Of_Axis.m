function [RotX,RotY,RotZ] = Rotation_Of_Axis(Angle)

Angle=deg2rad(Angle);

disp("RotX=[1 0 0;0 cos(Angle) -sin(Angle);0 -sin(Angle) cos(Angle)]")
RotX=[1 0 0;0 cos(Angle) -sin(Angle);0 -sin(Angle) cos(Angle)];

disp("RotY=[cos(Angle) 0 -sin(Angle);0 1 0;-sin(Angle) 0 cos(Angle)]")
RotY=[cos(Angle) 0 -sin(Angle);0 1 0;-sin(Angle) 0 cos(Angle)];

disp("RotZ=[cos(Angle) -sin(Angle) 0;sin(Angle) cos(Angle) 0;0 0 1]")
RotZ=[cos(Angle) -sin(Angle) 0;sin(Angle) cos(Angle) 0;0 0 1];

end