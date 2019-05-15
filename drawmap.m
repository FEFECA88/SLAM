function drawmap(states, factors)

figure(1); %Crea la ventana figure(1)
ah = cla; %cla limpia las figuras anteriores
hold on; %conserva la parcela de los ejes actuales
axis equal %hace que los 3 ejestengan la misma relación

rob0 = [-1 -1 2 -1; -1 1 0 -1] * 0.07; % a triangle at the origin

% Draw states
for i = 1 : numel(states) %devuelve el número de elementos, i, en array states, equivalente a prod(size(states).
    
    state = states{i};
    
    switch state.type
        
        case 'pose'
            th  = state.value(3);
            R   = [cos(th) -sin(th) ; sin(th) cos(th)];
            rob = repmat(state.value(1:2), 1, 4) + R*rob0; % rotate and translate triangle
            line(ah, rob(1,:), rob(2,:),'marker','none','color','b');
       
        case 'lmk'
            line(ah, state.value(1), state.value(2),'marker','*','color','r');
    
    end
end

% Draw factors
for k = 1 : numel(factors)
   
    factor = factors{k};

    switch factor.type
        
        case {'motion', 'lmk'}        
            i = factor.index(1);
            j = factor.index(2);
            pi = states{1+ i }.value(1:2);
            pj = states{1+ j }.value(1:2);
            line(ah, [pi(1) pj(1)],[pi(2) pj(2)],'color','g');
        
    end
    
end

drawnow;

end            
