function [ vec ] = Obt_RotVec(axis, angle)
%ROTVEC:
%input arguments: axis around will be done the rotation + angle (radians)
vec = axis/(norm(axis)) * angle;
end
