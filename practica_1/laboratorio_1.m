function [u]=laboratorio_1(I0,I1,a,b,c,f,alpha,betha) 
%como entradas de mi función en este orden de izquierda a derecha pongo:
%extremo inicial, extremo final y las funciones de identico nombre en el
%enunciado de la practica
for i=2:6
n=2^i-1;
V=linspace(I0,I1,n+2);h(i-1)=(I1-I0)/(n+1);%paso y malla donde trabajo
F1=f(V(2:n+1));F2=[(a(V(2))/h(i-1)^2+b(V(2))/(2*h(i-1)))*alpha(0) zeros(1,n-2) (a(V(n+1))/h(i-1)^2-b(V(n+1))/(2*h(i-1)))*betha(1)];F=sparse((F1+F2)');
%defino el termino independiente como suma de dos vectores
W1=sparse((2*a(V(2:n+1))/h(i-1)^2+c(V(2:n+1))));W1=diag(W1);W2=sparse((-a(V(2:n))/h(i-1)^2+b(V(2:n))/(2*h(i-1))));W2=diag(W2,1);W3=sparse([-a(V(3:n+1))/h(i-1)^2-b(V(3:n+1))/(2*h(i-1))]);W3=diag(W3,-1);
A=W1+W2+W3;%defino la forma matricial
u=A\F;solucion=@(x) exp(-5*x.*(1-x));%solucion numerica y analitica
err(i-1)=max(abs(u-(solucion(V(2:n+1)))'));  
figure(i-1)
plot(V(2:n+1),solucion(V(2:n+1)),'r')
hold on
plot(V(2:n+1),u,'g')
title('analitica(rojo) frente numerica (verde)')
end
figure(7)
loglog(h,err,'r')
hold on
loglog(h,h.^2,'g')
title('error(rojo) frente paso cuadrado (verde)')
end