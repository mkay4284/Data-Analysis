function LS_CamLOT01_FB_VoltPlots(Adjhdata,Adjvdata,t,mmlim,uradlim,V)

%------------- LOCAL DECLARATIONS -------------%


%------------- TIME-SERIES PLOTS --------------%
f=figure('Position',[20 300 1050 500]);

subplot(2,2,1)
hp = plot(t,Adjhdata,'.'); set(gca,'fontsize',13); axis([min(t) max(t) mmlim]);
title('CamLOT01 Horizontal Position'); xlabel('Timestamp'); ylabel('X_c (mm)'); 
yyaxis right; axis([xlim uradlim]); ylabel('X_c (\murad)'); set(gca,'ycolor',[.15 .15 .15]);
hpax = gca; 
[hts] = LS_CamLOT01_ReconstructTimeStamp(hpax.XTick'); 
hpax.XTickLabels = hts;

subplot(2,2,2)
vp = plot(t,Adjvdata,'.','color',[.85 .325 .098]); set(gca,'fontsize',13); axis([min(t) max(t) mmlim]);
title('CamLOT01 Vertical Position'); xlabel('Timestamp'); ylabel('Y_c (mm)'); vslim = ylim;
yyaxis right; axis([xlim uradlim]); ylabel('Y_c (\murad)'); set(gca,'ycolor',[.15 .15 .15]);
vpax = gca;
[vts] = LS_CamLOT01_ReconstructTimeStamp(vpax.XTick'); 
vpax.XTickLabels = vts;

%--------------- VOLTAGE PLOTS ---------------%
subplot(2,2,3)
hv = plot(t,V(:,1),'.'); axis([min(t) max(t) 0 10]);
title('Horizontal Piezo Control Voltage'); xlabel('Timestamp'); ylabel('Piezo Voltage (V)');
set(gca,'fontsize',13,'xticklabels',hts);

subplot(2,2,4)
vv = plot(t,V(:,2),'.','color',[.85 .325 .098]); axis([min(t) max(t) 0 10]);
title('Vertical Piezo Control Voltage'); xlabel('Timestamp'); ylabel('Piezo Voltage (V)');
set(gca,'fontsize',13,'xticklabels',vts);
end
