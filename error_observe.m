%estem mirant el residu de "d"
%Ens entren els dos estats del robot i del landmark
function [e, J_e_rob, J_e_lmk] = error_observe(rob, lmk, y)
%in:
% rob: robot pose (x, y; th)
% lmk: landmark position (px, py)
% y: polar measurement (d,a)
%
% out:
% e: estimation error
% J_e_rob: Jacobian of error wrt. robot pose (2x3 matrix) (with respect to)
% J_e_lmk: Jacobian of error wrt. landmark position (2x2 matrix)

%h: expected measurement in polars, distance and angle
[h, J_h_rob, J_h_lmk] = observe(rob, lmk);

%error
e = h - y;  % = y - h
J_e_h = eye(2);
%no ens interessa J_e_y = -eye(2); 

%regla de la cadena
J_e_rob = J_e_h * J_h_rob;
J_e_lmk = J_e_h * J_h_lmk;
%J_e_y = J_e_h * J_h_y; %no la necessitem per a res, Y es un estat, no una mesura

end

