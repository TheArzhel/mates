function RotMat=Quat_To_RotMat(Quat)

%%HELP
%Input an Quaternion to change it into rotation Rotation Matrix (nani)
% Quaternion must be 1x4, the first term being the integer part.

 QuatNorm=sqrt(Quat(1)^2+Quat(2)^2+Quat(3)^2+Quat(4)^2);

%unit quaternion
Versor = Quat/QuatNorm;
Quat = Versor;

QuatVec=Quat(2:length(Quat));
QuatVec = QuatVec/norm(QuatVec);

QuatVec = reshape(QuatVec,[3,1]);

QMatP=[0 -QuatVec(3,1) QuatVec(2,1);QuatVec(3,1) 0 -QuatVec(1,1); -QuatVec(2,1) QuatVec(1,1) 0];

a= Quat(1)^2 + Quat(2)^2-Quat(3)^2-Quat(4)^2;

b= 2*Quat(2)*Quat(3)- 2*Quat(1)*Quat(4);

c=2*Quat(2)*Quat(4)+2*Quat(1)*Quat(3);

d= 2*Quat(2)*Quat(3)+2*Quat(1)*Quat(4);

e= Quat(1)^2-Quat(2)^2+Quat(3)^2-Quat(4)^2;

f=2*Quat(3)*Quat(4)-2*Quat(1)*Quat(2);

g=2*Quat(2)*Quat(4)-2*Quat(1)*Quat(3);

h=2*Quat(3)*Quat(4)+2*Quat(1)*Quat(2);

i=Quat(1)^2-Quat(2)^2-Quat(3)^2+Quat(4)*2;

disp ('quat to rotation matrix')
RotMat = [a b c; d e f; g h i]



end
