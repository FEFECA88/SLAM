%OK
function [p, J_p_f, J_p_pf] = fromFrame2D(F,pf)
%volem transformar un punt d'un sistema de referencia a un altre
%F=robot, p=punt en referencia F

T=F(1:2);
th=F(3); %Rotació de la matriu

R=[cos(th) -sin(th); sin(th) cos(th)]; %matriu de rotació
p=R*pf + T; %Transformació d'un sistema a un altre

%Jacobiana de l'expresió que tenim a sobre:
J_p_pf=R;

pfx=pf(1);
pfy=pf(2);

%L'altre Jacobiana és més complicada, és el resultat de la funció inferior:
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