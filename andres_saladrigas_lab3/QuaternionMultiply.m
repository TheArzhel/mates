function NewQuat=QuaternionMultiply(Firstquaternion,Secondquaternion)
%%HELP
%introduce 2 quaternions. this function multiply them and then throw the
%result

% resize to be sure about dimentions
Firstquaternion = reshape(Firstquaternion,[1 4]);
Secondquaternion = reshape(Secondquaternion,[1 4]);

% take the first element
Real = Firstquaternion(1);
Real2 = Secondquaternion(1);

% take the vectorial part
VectorFQuat = reshape(Firstquaternion(2:length(Firstquaternion)),[1 3]);
VectorSQuat = reshape(Secondquaternion(2:length(Secondquaternion)),[1 3]);

%multiply and apply formula
var1 = Real*Real2;
var2 = VectorFQuat*VectorSQuat';

disp ('new quat after multiply')
NewQuat=[var1-var2 ((Real*VectorSQuat)+(Real2*VectorFQuat)+cross(VectorFQuat,VectorSQuat))]'

end