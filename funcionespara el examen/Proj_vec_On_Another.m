function [ProjectedVec,Perp_component]=Proj_vec_On_Another(Vector,direction)
%direction vectoir is the one you are proyectin into
% example, pory a into b. b is direction
%ProjectedVec=parallelcomponnet

ProjectedVec=(Vector*direction')*(direction/norm(direction)^2);

Perp_component=Vector-ProjectedVec;

%% remember a vecto = vectorParalel + vector perpendicular



%frame to frame
%-bRa*ada->b=bdb->a
end