% Cargar archivo con señales ECG
load('ecg_data.mat');

% Graficar señales de ECG sin ruido y con ruido
figure(1);
subplot(2,1,1);
plot(ecg);
title('ECG sin ruido');
subplot(2,1,2);
plot(ecg_noisy);
title('ECG con ruido');
sgtitle('Señales ECG originales')

% Calcular DFT
ecg_dft = fft(ecg);                             % Calcular la DFT de la señal sin ruido
ecg_noisy_dft = fft(ecg_noisy);                 % Calcular la DFT de la señal ruidosa
ecg_noisy_dB = mag2db(abs(ecg_noisy_dft));      % Calcular la magnitud de la DFT en dB

figure(2);
subplot(2,1,1);
plot(mag2db(abs(ecg_dft)));
title('Espectro de Fourier del ECG sin ruido');
ylabel('Magnitud (dB)');
subplot(2,1,2);
plot(ecg_noisy_dB);
title('Espectro de Fourier del ECG con ruido');
ylabel('Magnitud (dB)');
sgtitle('Espectos de Fourier')


% Aplicar un filtro para eliminar el ruido
for i = 1:2         % Repetir el proceso
    % Determina la maxima diferencia entre la señal sin ruido y con ruido
    % Lo importante es el indice
    [num_max, ind_max] = max(abs(ecg_dft-ecg_noisy_dft));
    % Se elimina la muestra con dicho indice 
    ecg_noisy_dft(ind_max) = 0;
end

% Calcular la inversa de la DFT para obtener la señal limpia
ecg_clean = ifft(ecg_noisy_dft);

% Graficar la señal limpia y comparar con la señal original
figure(3); clf;
subplot(2,1,1);
plot(ecg);
title('ECG sin ruido');
ylabel('Amplitud');
subplot(2,1,2);
plot(real(ecg_clean));
title('ECG limpio');
ylabel('Amplitud');
sgtitle('ECG original y limpio');
