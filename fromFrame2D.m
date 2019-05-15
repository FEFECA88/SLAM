%OK
function [p, J_p_f, J_p_pf] = fromFrame2D(F,pf)
%volem transformar un punt d'un sistema de referencia a un altre
%F=robot, p=punt en referencia F

T=F(1:2);
th=F(3); %Rotaci� de la matriu

R=[cos(th) -sin(th); sin(th) cos(th)]; %matriu de rotaci�
p=R*pf + T; %Transformaci� d'un sistema a un altre

%Jacobiana de l'expresi� que tenim a sobre:
J_p_pf=R;

pfx=pf(1);
pfy=pf(2);

%L'altre Jacobiana �s m�s complicada, �s el resultat de la funci� inferior:
J_p_f = [...
    [1, 0, -pfy*cos(th) - pfx*sin(th)]
    [0, 1,  pfx*cos(th) - pfy*sin(th)]
];
end

function f()
%%
syms x y th real
%Si no posem "real" les genera com a "complexes"
F=[x;y;th];
syms pfx pfy real
pf=[pfx;pfy];

p=fromFrame2D(F, pf);

J_p_f=simplify(jacobian(p,F))
end