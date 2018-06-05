function [palabra]=inv_segmentacion(segmentos,despl)
    % Concatenar segmentos sin tener en cuenta despl
    % Reservamos memoria
    %palabra=zeros(num,size(segmentos,2));
    palabra=[];
    for i=1:size(segmentos,2)
       % Recortar segmento y luego acoplar
       seg=segmentos(1:despl,i);
       %palabra(i,1:length(seg))=seg;
       palabra=[palabra; seg];
    end
end