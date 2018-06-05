function [salida]=cruces_por_cero(segmentos, ventana)
    diferencia=abs(sign(segmentos(1:end-1,:))-sign(segmentos(2:end,:)));
    sumatorio=sum(enventanado(diferencia,ventana)/2);
    salida = sumatorio/(size(segmentos,1));
end