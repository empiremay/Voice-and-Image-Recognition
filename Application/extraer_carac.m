function [vect, palabra]=extraer_carac()
    Fs=8000;
    canales=1;
    num_bits=16;
    tiempo=3;
    senal=grabacion(tiempo, Fs, canales, num_bits);
    senal=senal(1000:end);
    a=0.95;
    y=preenfasis(senal,a);
   
    segmentos=segmentacion(y, 0.03*Fs, 0.01*Fs);
   
    [segmentos,ini,fin]=inicio_fin(segmentos,10);
    palabra=inv_segmentacion(segmentos,0.01*Fs);

    [segmentos_enventados]=enventanado(segmentos, 'haming');
    
    % Extracción de características
    coefs=rceps(segmentos_enventados);
    coefs=coefs(2:13,:);
    
    p=10;
    mascara=-p:p;
    masc_ampl=repmat(size(coefs,1),1);
    coefs_ampl=[zeros(size(coefs,1),p) coefs zeros(size(coefs,1),p)];
    den=[zeros(1,p) ones(1,size(coefs,2)) zeros(1,p)];
    delta=zeros(size(coefs));
    for i=1:size(coefs,2)
        delta(:,i)=sum(masc_ampl.*coefs_ampl(:,i:2*p+i),2);
        delta_den=sum((mascara.^2).*den(i:2*p+i));
        delta(:,i)=delta(:,i)./delta_den;
    end
    vect=[coefs; delta];
    vect=zeromean(vect)./repmat(stdpat(vect),1,size(vect,2));
end