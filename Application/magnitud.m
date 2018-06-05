function [salida]=magnitud(segmentos, ventana)
    % Sumatorio del valor absoluto por columna
    if isequal(ventana,'haming')
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=hamming(filas);
        vector=repmat(vector,1,columnas);
        salida=sum(abs(segmentos.*vector));
    elseif isequal(ventana,'haning')
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=hanning(filas);
        vector=repmat(vector,1,columnas);
        salida=sum(abs(segmentos.*vector));
    else
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=rectwin(filas);
        vector=repmat(vector,1,columnas);
        salida=sum(abs(segmentos.*vector));
    end
end