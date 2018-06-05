function [segmentos]=segmentacion(senal, num_muestras, despl)
    segmentos=buffer(senal, num_muestras, num_muestras-despl,'nodelay');
end