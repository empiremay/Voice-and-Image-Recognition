function [valor, DTW]=DTW(p,t)
    n=size(p,2)+1;
    m=size(t,2)+1;
    DTW=zeros(n,m);
    DTW(:,1)=Inf;
    DTW(1,:)=Inf;
    DTW(1,1)=0;
    for i=2:n
       for j=2:m
           distancia=d_euclid(p(:,i-1),t(:,j-1));
           DTW(i,j)=distancia+min(DTW(i-1,j),min(DTW(i,j-1), DTW(i-1,j-1)));
       end
    end
    valor=DTW(end,end);
end