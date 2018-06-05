function [segmentos,ini,fin]=inicio_fin(segmentos, num_segmentos_ruido)
    N=size(segmentos,2);
    Z=cruces_por_cero(segmentos,'haming');
    M=magnitud(segmentos,'haming');
    
    Ms=M(1:num_segmentos_ruido);
    Zs=Z(1:num_segmentos_ruido);
    
%     UmbSupEnrg = 0.5*max(M);
%     UmbInfEnrg = mean(Ms)+2*std(Ms);
%     UmbCruCero = mean(Zs)+2*std(Zs);
    
    UmbSupEnrg = 0.5*max(M);
    UmbInfEnrg = mean(Ms)+2*std(Ms);
    UmbCruCero = mean(Zs)+2*std(Zs);
    
    indice=find(M(num_segmentos_ruido+1:end)>UmbSupEnrg,1,'first');
    ln_ini=num_segmentos_ruido+1+indice;
    
    indice=find(M(1:N-num_segmentos_ruido-1)>UmbSupEnrg,1,'last');
    ln_fin=indice;
    
    le_ini=find(M(1:ln_ini)<UmbInfEnrg,1,'last');
    
    indice=find(M(ln_fin:end)<UmbInfEnrg,1,'first');
    le_fin=ln_fin+indice;
    
    times=0;
    n=le_ini;
    salir=false;
    while n>=le_ini-25 & n>1 & ~salir
        if Z(n) < UmbCruCero
            salir=times>=3;
            times=0;
        end
        
        if Z(n) > UmbCruCero
            times = times+1;
        end
        n=n-1;
    end
    
    if salir
        lz_ini=n+1;
    else
        lz_ini=le_ini;
    end
    
    times=0;
    n=le_fin;
    salir=false;
    while n<=le_fin+25 & n<length(Z) & ~salir
        if Z(n) < UmbCruCero
            salir=times>=3;
            times=0;
        end
        
        if Z(n) > UmbCruCero
            times = times+1;
        end
        n=n+1;
    end
    
    if salir
        lz_fin=n;
    else
        lz_fin=le_fin;
    end
    ini=lz_ini;
    fin=lz_fin;
    if(isempty(fin))
        segmentos=segmentos(:,lz_ini:end);
        %disp('Se han cogido todos los segmentos desde inicio');
        fin=size(segmentos,2);
    else
        segmentos=segmentos(:,lz_ini:lz_fin);
    end
end