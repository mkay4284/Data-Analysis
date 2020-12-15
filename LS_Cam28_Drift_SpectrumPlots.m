function LS_Cam28_Drift_SpectrumPlots(Adjhdata,Adjvdata,t,mmlim,uradlim,L)

%------------- LOCAL DECLARATIONS -------------%
fs = 3.33;                            %Sampling freq. (Hz)
[X,fx] = Spectrum(Adjhdata,fs);     %call Spectrum for horz
[Y,fy] = Spectrum(Adjvdata,fs);     %call Spectrum for vert

%------------- TIME-SERIES PLOTS --------------%
f=figure('Position',[20 300 1050 500]);

subplot(2,2,1)
hp = plot(t,Adjhdata,'.'); set(gca,'fontsize',13); axis([min(t) max(t) mmlim]);
title('Horizontal Drift'); xlabel('Timestamp'); ylabel('X_c (mm)'); 
yyaxis right; axis([xlim uradlim]); ylabel('X_c (\murad)'); set(gca,'ycolor',[.15 .15 .15]);
hpax = gca; 
[hts] = LS_Cam28_ReconstructTimeStamp(hpax.XTick'); 
hpax.XTickLabels = hts;

subplot(2,2,2)
vp = plot(t,Adjvdata,'.','color',[.85 .325 .098]); set(gca,'fontsize',13); axis([min(t) max(t) mmlim]);
title('Vertical Drift'); xlabel('Timestamp'); ylabel('Y_c (mm)'); vslim = ylim;
yyaxis right; axis([xlim uradlim]); ylabel('Y_c (\murad)'); set(gca,'ycolor',[.15 .15 .15]);
vpax = gca;
[vts] = LS_Cam28_ReconstructTimeStamp(vpax.XTick'); 
vpax.XTickLabels = vts;

%--------------- SPECTRUM PLOTS ---------------%
subplot(2,2,3)
hs = semilogx(fx,1000*X,'.-','color',[0 .447 .741]); hslim = ylim;
axis([.001 max(fx) ylim]); set(gca,'fontsize',12,'xtick',[.001 .01 .1 1 10])
title('Horizontal Amplitude Spectrum'); xlabel('Frequency (Hz)'); ylabel('Amplitude (\mum)');
yyaxis right; set(gca,'ycolor',[.15 .15 .15]); axis([xlim 1e6*atan(ylim/L)]);
ylabel('Amplitude (\murad)')

subplot(2,2,4)
vs=semilogx(fy,1000*Y,'.-','color',[.85 .325 .098]); vslim = ylim;
if max(hslim) > max(vslim)
    axis([.001 max(fx) hslim]);
end
set(gca,'fontsize',12,'xtick',[.001 .01 .1 1 10])
title('Vertical Amplitude Spectrum'); xlabel('Frequency (Hz)'); ylabel('Amplitude (\mum)');
yyaxis right; set(gca,'ycolor',[.15 .15 .15]); axis([xlim 1e6*atan(ylim/L)]);
ylabel('Amplitude (\murad)')


if max(vslim) > max(hslim)
    subplot(2,2,3)
    axis([xlim 1e6*atan(vslim/L)]);
    yyaxis left; axis([xlim vslim]);
end
    
end
