function RotatedVector=Vector_Rotation_With_Quaternions(Vec,Quat)
%%HELP
% introduce first a Vector you want to rotate and then a Quaternion. the
% funtion will give the new vector rotated

% be sure about the dimentions
Vec=reshape(Vec,[1,3]);
Quat=reshape(Quat,[1,4]);

QuatNorm=sqrt(Quat(1)^2+Quat(2)^2+Quat(3)^2+Quat(4)^2);

% get unit quaternion
Versor = Quat/QuatNorm;
Quat = Versor;

% pure quaternion
PureVec = [0 Vec];
QuatVec = Quat(2:length(Quat));
QuatConjugate = [Quat(1) -QuatVec];

QuatVec = QuaternionMultiply(QuaternionMultiply(Quat,PureVec),QuatConjugate);
disp('next')
disp(QuatVec)
RotatedVector=QuatVec(2:length(QuatVec));
RotatedVector=RotatedVector';

disp('Rotated Vector with quaternions is')
disp(RotatedVector)

end