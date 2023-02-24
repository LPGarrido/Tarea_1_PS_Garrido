% Cargar archivos de audio
% -> x1 = bater�a
% -> x2 = bajo
% -> x3 = armon�a
[x1, fs1] = audioread('beat.wav');
[x2, fs2] = audioread('beat.wav');
[x3, fs3] = audioread('harmony.wav');
Fs = min([fs1, fs2, fs3]);
% Tama�os de las se�ales
N1 = length(x1);
N2 = length(x2);
N = length(x3);

% Arrays para almacenar la extensi�n peri�dica de x1[n] y x2[n]
y1 = zeros(size(x3));
y2 = zeros(size(x3));

% Realizar extensi�n peri�dica por medio de modulo indexing. La funci�n
% mod de MATLAB puede ser �til. Recordar tambi�n que el primer �ndice en 
% los arrays de MATLAB es 1, no 0 como es usual en los lenguajes de 
% programaci�n.
for item = 0:(N-1)
    y1(item+1, :) = x1(mod(item, length(x1))+1, :);
    y2(item+1, :) = x2(mod(item, length(x2))+1, :);
end

% Se genera una se�al rampa que cambie desde 0 hasta 1, con la misma 
% longitud que la pista de armon�a.
w = linspace(0, 1, length(x3));
% Implementar el fade-in como la multiplicaci�n de la se�al rampa con la
% pista de armon�a.
y3 = x3 .* w';

en_fade_in = false; % Seleccionar si se desea o no el efecto de fade-in.

a1 = 0.3;   % Bateria
a2 = 0.3;   % Bajo
a3 = 0.4;   % Harmon�a
G = 2;

% Implementar el mixer digital que combine la pista de armon�a con las
% extensiones peri�dicas de las pistas de bater�a y bajo.
if(en_fade_in)
    % Implementar el fade-in como la multiplicaci�n de la se�al rampa con la
    % pista de armon�a.
    x_mix = a1*y1 + a2*y2 + a3*y3;
else
    x_mix = a1*y1 + a2*y2 + a3*x3;
end

x_mix = G*x_mix/max(max(x_mix));

% Probar si los resultados son los esperados
sound(x_mix, Fs);

% Graficar la se�al lineal utilizada para el fade-in
figure(3); clf;
plot(w);
xlabel('Muestras');
ylabel('Amplitud');
title('Se�al lineal para efecto de "fade-in"'); 