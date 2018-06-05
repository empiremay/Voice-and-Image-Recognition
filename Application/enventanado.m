function [segmentos_enventados]=enventanado(segmentos, ventana)
    if isequal(ventana,'haming')
        filas=size(segmentos,1);    % Longitud de los segmentos
        columnas=size(segmentos,2); % Numero de segmentos
        segmentos_enventados=zeros(filas,columnas);
        vector=hamming(filas);	% Hacerlo por filas en vez de por columnas
        for i=1:filas
            for j=1:columnas
                segmentos_enventados(i,j)=segmentos(i,j)*vector(i);
            end
        end
    else if isequal(ventana,'haning')
            filas=size(segmentos,1);
            columnas=size(segmentos,2);
            segmentos_enventados=zeros(filas,columnas);
            vector=hanning(filas);
            for i=1:filas
                for j=1:columnas
                    segmentos_enventados(i,j)=segmentos(i,j)*vector(i);
                end
            end
        else
            segmentos_enventados=segmentos;
        end
    end
end