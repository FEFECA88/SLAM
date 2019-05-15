function [lmk, J_lmk_rob, J_lmk_y] = inv_observe(rob, y)
%rob=posició del robot
%Lmk= posició land mark
%tenim coordenades polars i volem cartesianes

%volem el landmark en coordenades cartesianes:
[lmkrob, J_lmkrob_y] = p2c(y);

[lmk, J_lmk_rob, J_lmk_lmkrob] = fromFrame2D(rob, lmkrob);
%ja tenim el landmark en coordenades del mon desde el frame robot

%regla de la cadena, començar per "lmk" i acabar per "y"
J_lmk_y= J_lmk_lmkrob * J_lmkrob_y;

end

%Comprobació: no fa falta, doncs ja hem comprobat abans

