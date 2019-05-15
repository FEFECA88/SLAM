%OK
function [y, J_y_rob, J_y_lmk] = observe(rob, lmk)
%rob=posici� del robot
%Lmk= posici� land mark
%tenim coordenades cartesianes i volem polars

[lmkrob, J_lmkrob_rob, J_lmkrob_lmk] = toFrame2D(rob, lmk);


%ja tenim el landmark en coordenades del robot

%volem el resultat en polars:
[y, J_y_lmkrob] = c2p(lmkrob);

%regla de la cadena, comen�ar per "y" i acabar per "rob"
%J_y_rob = J_y_#### * J_####_rob
J_y_rob = J_y_lmkrob * J_lmkrob_rob;
J_y_lmk = J_y_lmkrob * J_lmkrob_lmk;
end

%Comprobaci�
function f()
%%
syms x y th px py real
r = [x;y;th];
p = [px;py];

[yy, J_yy_r, J_yy_p] = observe(r,p);
simplify(jacobian(yy,r) - J_yy_r)
simplify(jacobian(yy,p) - J_yy_p)
end
%dona matrius ZERO
