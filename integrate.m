function integrate(Wq,Mq,Aq,DATAq,trap,simp)


%%%%%%%%%%%%integrate values%%%%%%%%%%%%%

%trap rule
if(trap==1)
    int=0;
    wsum=0;
    for i=1:numel(Mq(:,1,1))
        if(i==1 || i==numel(Mq(:,1,1)));
            wi=1/2;
        else
            wi=1;
        end
        
        for j=1:numel(Wq(1,:,1))
            if(j==1 || j==numel(Wq(1,:,1)));
                wj=1/2;
            else
                wj=1;
            end
            
            for k=1:numel(Aq(1,1,:))
                if(k==1 || k==numel(Aq(1,1,:)));
                    wk=1/2;
                else
                    wk=1;
                end
                
                w=wi*wj*wk;
                wsum=wsum+w;
                int=int+w*DATAq(i,j,k);
                
            end
        end
    end
    %print integral value
    int=int/wsum;
    fprintf('Trapezoidal Rule Integration Equals: %d\n',int)
end

%simps rule
if(simp==1)
    if(mod(numel(Mq(:,1,1)),2)==0 || mod(numel(Wq(1,:,1)),2)==0 || mod(numel(Aq(1,1,:)),2)==0)        
        fprintf('Simpsons Rule Does not work with number of points\n')
    else
        int=0;
        wsum=0;
        for i=1:numel(Mq(:,1,1))
            if(i==1 || i==numel(Mq(:,1,1)));
                wi=1/6;
            elseif(mod(i,2)==0)
                wi=4/6;
            else
                wi=2/6;
            end
            
            for j=1:numel(Wq(1,:,1))
                if(j==1 || j==numel(Wq(1,:,1)));
                    wj=1/6;
                elseif(mod(j,2)==0)
                    wj=4/6;
                else
                    wj=2/6;
                end
                
                for k=1:numel(Aq(1,1,:))
                    if(k==1 || k==numel(Aq(1,1,:)));
                        wk=1/6;
                    elseif(mod(k,2)==0)
                        wk=4/6;
                    else
                        wk=2/6;
                    end
                    
                    w=wi*wj*wk;
                    wsum=wsum+w;
                    int=int+w*DATAq(i,j,k);
                    
                end
            end
        end
        %print integral value
        int=int/wsum;
        fprintf('Simpsons Rule Integration Equals: %d\n',int)
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n')

end