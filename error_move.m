function [e, J_e_rob1, J_e_rob2] = error_move(rob1, rob2, drob_mesurada)
% in:
%   rob1: pose of robot at time 1
%   rob2: pose of robot at time 2
%   drob: motion measurement betwwwn times 1 and 2
%
% out:
%   e: expectation motion error (per modificar l'estat)
%   J_e_rob1: Jacobian of e wrt/ rob1
%   J_e_rob2: Jacobian of e wrt/ rob2
%   no incloem J_e_drob xk no la farem servir

%mesura esperada:
[dexp, J_dexp_rob1, J_dexp_rob2]= ...
    betweenFrames2D(rob1, rob2);

%expectation error
e = dexp - drob_mesurada;
J_e_drobdexp = eye(3);

%composition by chain rule
J_e_rob1 = J_e_drobdexp * J_dexp_rob1;
J_e_rob2 = J_e_drobdexp * J_dexp_rob2;

end







