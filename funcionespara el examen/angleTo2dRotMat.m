function rotMat = angleTo2dRotMat(angle)
%This function receives an angle in DEGREES

angle = deg2rad(angle);
rotMat = [cos(angle) -sin(angle); sin(angle) cos(angle)];

end