function [lmk, J_lmk_rob, J_lmk_y] = inv_observe(rob, y)
%rob=posici� del robot
%Lmk= posici� land mark
%tenim coordenades polars i volem cartesianes

%volem el landmark en coordenades cartesianes:
[lmkrob, J_lmkrob_y] = p2c(y);

[lmk, J_lmk_rob, J_lmk_lmkrob] = fromFrame2D(rob, lmkrob);
%ja tenim el landmark en coordenades del mon desde el frame robot

%regla de la cadena, comen�ar per "lmk" i acabar per "y"
J_lmk_y= J_lmk_lmkrob * J_lmkrob_y;

end

%Comprobaci�: no fa falta, doncs ja hem comprobat abans

