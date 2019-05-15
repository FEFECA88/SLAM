function states = updatestates(states,dx)

for state = 1:numel(states)
    
    states{state}.value= states{state}.value + dx(states{state}.range); %tallem dx i anem donant-li valors a trossos
    
    if strcmp (states{state}.type, 'pose')
        
        while states{state}.value(3) > pi
            states{state}.value(3) = states{state}.value(3)-2*pi;
        end
        
        while states{state}.value(3) < -pi
            states{state}.value(3) = states{state}.value(3)+2*pi;
        end
    end
    
end
end
