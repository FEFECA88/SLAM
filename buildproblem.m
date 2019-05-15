function [A, r] = buildproblem(states, factor)

K=numel(factor);

A = zeros(25,17);  
r = zeros(25,1);

row = 1;

for k=1:K
    
    y = factor{k}.measurement;
    W = factor{k}.covariance ^-1;
    Wt2 = chol(W, 'upper'); %sqrt d'una matriu
    
    
    switch(factor{k}.type)
        case 'motion'
            i=factor{k}.index(1);
            j=factor{k}.index(2);
            rob1=states{1+i};  %vector de 3 estat 1
            rob2=states{1+j};  %estat 2
            [e, J_e_rob1, J_e_rob2] = error_move (rob1.value, rob2.value, y);  %posicions dels robots i y= mesura de moviemtn
            
            rows = [row : (row + numel(y) -1)]; %3x3, 2x3, etc
            
            A(rows, rob1.range) = Wt2 * J_e_rob1;  %afegim les files i columnes a la matriu
            A(rows, rob2.range) = Wt2 * J_e_rob2;
            r(rows) = Wt2 * e;
            
        case 'lmk'
            i=factor{k}.index(1);
            j=factor{k}.index(2);
            rob=states{1+i};
            lmk=states{1+j}; %vector de 2
            [e, J_e_rob, J_e_lmk] = error_observe (rob.value, lmk.value, y);
            
            rows = [row : (row + numel(y) -1)]; %3x3, 2x3, etc
            
           
            A(rows, rob.range) = Wt2 * J_e_rob;  %afegim les files i columnes a la matriu
            A(rows, lmk.range) = Wt2 * J_e_lmk;
            r(rows) = Wt2 * e;
            
        case 'pose'
            i=factor{k}.index(1);
            % j=factor{k}.index(2); No fa falta en absolut
            rob = states{1+i};
            [e, J_e_rob] = error_pose (rob.value, y);
            
            rows = [row : (row + numel(y) -1)]; %3x3, 2x3, etc
            r(rows) = Wt2 * e;
            A(rows, rob.range) = Wt2 * J_e_rob; 
            
            
    end
    
    row= row + numel(y);
    
end
end