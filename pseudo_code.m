%%Necessitem: State and measures sizes:

%hem guardat els tipus de mesura en un lloc que es diu "factor", on tindrem
%els index i totes les coses.


%%Necessitem: State and measures sizes:
pose_size = 3;
lmk_size  = 2;
motion_size = 3;


%
num_poses_states = 3;
num_lmk_states = 4;
num_motion_factors = 2;
num_pose_factors = 1;
num_lmk_factors = 8;

torad = pi/180;

%


factor{1+ 0} = struct(...
    'type', 'pose',...
    'measurement', [0;0;0],...
    'covariance', 1e-3*eye(3,3),...   %si la primera es zero �s perill�s
    'index', 0); %abans estaba a 1

factor{1+ 1} = struct(...
    'type', 'motion',...
    'measurement', [1.0;0.0;-torad*5],...  %%hem avan�at 1 metre i hem girat 5 graus
    'covariance', diag([1e-2, 1e-2, (1*torad)^2]),...
    'index', [0,1]);

factor{1+ 2} = struct(...
    'type', 'motion',...
    'measurement', [1.05;-0.25;-15*torad],...  %%hem avan�at 1.05 metre i hem girat 3 graus
    'covariance', diag([1e-2, 1e-2, (1*torad)^2]),...  %%hauria de ser proporcional al moviment
    'index', [1,2]);

factor{1+ 3} = struct(...
    'type', 'lmk',...
    'measurement', [1.2;torad*40],...  %%est� a 1.2 metres i 40 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [0,3]);

factor{1+ 4} = struct(...
    'type', 'lmk',...
    'measurement', [0.67;torad*95],...  %%est� a 0.67 metres i 95 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [1,3]);

factor{1+ 5} = struct(...
    'type', 'lmk',...
    'measurement', [1.5;torad*30],...  %%est� a 1.5 metres i 20 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [1,4]);

factor{1+ 6} = struct(...
    'type', 'lmk',...
    'measurement', [1.6;-35*torad],...  %%est� a 1.2 metres i 40 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [0,5]);

factor{1+ 7} = struct(...
    'type', 'lmk',...
    'measurement', [0.9;-75*torad],...  %%est� a 0.9 metres i 75 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [1,5]);

factor{1+ 8} = struct(...
    'type', 'lmk',...
    'measurement', [2.8;-28*torad],...  %%est� a 2.8 metres i 28 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [0,6]);

factor{1+ 9} = struct(...
    'type', 'lmk',...
    'measurement', [1.8;-35*torad],...  %%est� a 1.2 metres i 40 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [1,6]);

factor{1+ 10} = struct(...
    'type', 'lmk',...
    'measurement', [0.7;-40*torad],...  %%est� a 1.2 metres i 40 graus positius
    'covariance', diag([1e-2, (1*torad)^2]),...  %%hauria de ser proporcional a la mesura
    'index', [2,6]);


% STATES
states{1+ 0}= struct(...
    'type', 'pose',...
    'range',[1;2;3],... %%est� en els 3 primers valors del vector d'estat X de 1X7
    'value', [0;0;0]...
    ); 

states{1+ 1}= struct(...
    'type', 'pose',...
    'range',[4;5;6],... 
    'value', [0;0;0]... %%quan resolguem ja escriurem sobre aquesta posici�
    ); 

states{1+ 2}= struct(...
    'type', 'pose',...
    'range',[7;8;9],... 
    'value', [0;0;0]...
    ); 

states{1+ 3}= struct(...
    'type', 'lmk',...
    'range',[10;11],... 
    'value', [1;0]...
    );

states{1+ 4}= struct(...
    'type', 'lmk',...
    'range',[12;13],... 
    'value', [1;0]... 
    );

states{1+ 5}= struct(...
    'type', 'lmk',...
    'range',[14;15],... 
    'value', [1;0]... 
    );

states{1+ 6}= struct(...
    'type', 'lmk',...
    'range',[16;17],... 
    'value', [1;0]... 
    );

dx = ones(17,1) * 1e6;
eps = 1e-6;


while norm(dx) > eps
    [A,r]= buildproblem(states, factor);
    dx = solvelinearized(A,r);
    
    states = updatestates(states, dx);
    drawmap(states, factor);
    
end




