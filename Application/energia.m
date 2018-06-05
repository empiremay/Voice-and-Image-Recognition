function [salida]=energia(segmentos, ventana)
    % Sumatorio de los cuadrados por columna
    if isequal(ventana,'haming')
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=hamming(filas);
        vector=repmat(vector,1,columnas);
        salida=sum((segmentos.*vector).^2);
    elseif isequal(ventana,'haning')
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=hanning(filas);
        vector=repmat(vector,1,columnas);
        salida=sum((segmentos.*vector).^2);
    else
        filas=size(segmentos,1);
        columnas=size(segmentos,2);
        vector=rectwin(filas);
        vector=repmat(vector,1,columnas);
        salida=sum((segmentos.*vector).^2);
    end
end