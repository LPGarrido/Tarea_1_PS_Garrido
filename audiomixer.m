% Cargar archivos de audio
% -> x1 = batería
% -> x2 = bajo
% -> x3 = armonía
[x1, fs1] = audioread('beat.wav');
[x2, fs2] = audioread('beat.wav');
[x3, fs3] = audioread('harmony.wav');
Fs = min([fs1, fs2, fs3]);
% Tamaños de las señales
N1 = length(x1);
N2 = length(x2);
N = length(x3);

% Arrays para almacenar la extensión periódica de x1[n] y x2[n]
y1 = zeros(size(x3));
y2 = zeros(size(x3));

% Realizar extensión periódica por medio de modulo indexing. La función
% mod de MATLAB puede ser útil. Recordar también que el primer índice en 
% los arrays de MATLAB es 1, no 0 como es usual en los lenguajes de 
% programación.
for item = 0:(N-1)
    y1(item+1, :) = x1(mod(item, length(x1))+1, :);
    y2(item+1, :) = x2(mod(item, length(x2))+1, :);
end

% Se genera una señal rampa que cambie desde 0 hasta 1, con la misma 
% longitud que la pista de armonía.
w = linspace(0, 1, length(x3));
% Implementar el fade-in como la multiplicación de la señal rampa con la
% pista de armonía.
y3 = x3 .* w';

en_fade_in = false; % Seleccionar si se desea o no el efecto de fade-in.

a1 = 0.3;   % Bateria
a2 = 0.3;   % Bajo
a3 = 0.4;   % Harmonía
G = 2;

% Implementar el mixer digital que combine la pista de armonía con las
% extensiones periódicas de las pistas de batería y bajo.
if(en_fade_in)
    % Implementar el fade-in como la multiplicación de la señal rampa con la
    % pista de armonía.
    x_mix = a1*y1 + a2*y2 + a3*y3;
else
    x_mix = a1*y1 + a2*y2 + a3*x3;
end

x_mix = G*x_mix/max(max(x_mix));

% Probar si los resultados son los esperados
sound(x_mix, Fs);

% Graficar la señal lineal utilizada para el fade-in
figure(3); clf;
plot(w);
xlabel('Muestras');
ylabel('Amplitud');
title('Señal lineal para efecto de "fade-in"'); 