%% Ejercicio 4a)
[x, fs] = audioread('beat.wav');
f = 2*fs;
sound(x,f)
%% Ejercicio 4b)
tic
% Cargar las señales de audio y resamplearlas
[x1, Fs1] = audioread('beat.wav');
[x2, Fs2] = audioread('bass.wav');
Fs = min(Fs1, Fs2);
x1 = resample(x1, Fs, Fs1);
x2 = resample(x2, Fs, Fs2);
% Definir los coeficientes de mezcla y la ganancia
a1 = 2; % coeficiente de mezcla de la señal 1 (bateria)
a2 = 0.25; % coeficiente de mezcla de la señal 2 (bajo)
G = 0.9; % ganancia de salida
% Mezclar las señales y normalizar la señal de salida
n = min(length(x1),length(x2));
xmix = zeros(n, 2);
xmax = 0;
%y = a1*x1 + a2*x2;
for i = 1:n
    xmix(i, :) = a1*x1(i, :) + a2*x2(i, :);
    xmax = max(xmax, max(abs(xmix(i, :))));
end
xmix = G*xmix/xmax;
% Graficar las señales originales y la salida del mixer
t = (0:n-1)/Fs;
toc

figure(1);
subplot(2,2,1);
plot(t, x1(:,1));
title('Señal de beat.wav (L)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
subplot(2,2,2);
plot(t, x1(:,2));
title('Señal de beat.wav (R)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
subplot(2,2,3);
plot(t, x2(:,1));
title('Señal de bass.wav (L)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
subplot(2,2,4);
plot(t, x2(:,2));
title('Señal de bass.wav (R)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
sgtitle('Señales de entrada')

figure(2);
subplot(2,1,1);
plot(t, xmix(:,1));
title('Salida del mixer (L)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
subplot(2,1,2);
plot(t, xmix(:,2));
title('Salida del mixer (R)');
xlabel('Tiempo (s)');
ylabel('Amplitud');
ylim([-1, 1]);
sgtitle('Señales de salida')