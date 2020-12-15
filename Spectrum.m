function [OneSided,f1] = Spectrum(data,fs)
%load('CamData.mat');
rng('default')
%data = hdata(:,2); %must be a column vector

if size(data,1) == 1
    data=data';
end
%------------------Parameters--------------%
N = size(data,1);             %Data length
%fs=10;                        %Sampling frequency
ts=1/fs;                      %Sampling interval
t=((0:N-1) * ts)';            %Time axis 
fax=((0:N-1) * fs/N)';        %Frequency axis


%---Signal in time and frequency domains---%
y=data;
y=resample(y,t);
%y=detrend(y,1);

window=hanning(N);
%y=y.*window;

% figure('Name',sprintf('Fs = %d kS/s, N= %d samples', fs/1000, N))
% subplot(4,2,1); plot(t/60,data,'.-'); grid                    %Signal
% title('Beam Drift'); ylabel('Camera Position [mm]'); xlabel('Time [min]')
% axis([0 max(t)/60 ylim])

Y=abs(fft(y));                                      
fY=[fax, (Y/(N/2))];                                  

% subplot(4,2,3); plot(fax,Y,'.-');            %Unscaled FT'
% title('Unscaled Two-Sided FT'); ylabel('Amplitude [mm*N]');xlabel('Frequency [Hz]')
% subplot(4,2,5); plot(fax,Y/N,'.-');             %Scaled FT
% title('Scaled Two-Sided FT'); ylabel('Amplitude [mm]');xlabel('Frequency [Hz]')

%-----------One sided FT--------------------%
f1=fax(1:N/2+1);
TwoSided = Y/N;
OneSided = TwoSided(1:N/2+1);
OneSided(2:end-1) = 2*OneSided(2:end-1);
% subplot(4,2,7); plot(f1,OneSided,'.-')
% title('Scaled One-Sided FT'); ylabel('Amplitude [mm]');xlabel('Frequency [Hz]')

%------------------POWER--------------------%

%PowerRef = bandpower(y, fs, [0, fs/2]);
%AmpRef = sqrt(2) * sqrt(PowerRef);
%nbw = enbw(window,fs);
nbw=1;

%dBP = 10* log10(OneSided.^2/2/PowerRef);
dBP = 10 * log10(OneSided.^2/2/max(OneSided.^2/2));
% subplot(4,2,2); plot(fax(1:N/2+1),dBP);
% title('Power Spectrum'); ylabel('Power [dB]'); xlabel('Frequency [Hz]');

%dBA = 20* log10(OneSided/AmpRef);
dBA = 20* log10(OneSided/max(OneSided));
% subplot(4,2,4); plot(fax(1:N/2+1),dBA); 
% title('Linear Spectrum'); ylabel('Amplitude [dB]'); xlabel('Frequency [Hz]');

PSD = dBP/nbw;
% subplot(4,2,6); plot(fax(1:N/2+1),PSD);
% title('Power Spectral Density'); ylabel('Power [dB/Hz]'); xlabel('Frequency [Hz]')

ASD = dBA/sqrt(nbw);
% subplot(4,2,8); plot(fax(1:N/2+1),ASD);
% title('Linear Spectral Density'); ylabel('Amplitude [dB/\surd{Hz}]'); xlabel('Frequency [Hz]')
end
