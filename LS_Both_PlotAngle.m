L = 3327;
ylims = [-1 1];
t = cam28(:,2);

delta_theta_x = (camLOT01(:,3) + cam28(:,3)) / L * 1000;
delta_theta_y = (camLOT01(:,4) + cam28(:,4)) / L * 1000;

figure;

subplot(2,1,1)
hp = plot(t,delta_theta_x,'.'); set(gca,'fontsize',12); axis([min(t) max(t) ylims]); 
title('Horizontal Tilt'); ylabel('\Delta\theta_x (mrad)'); xlabel('Timestamp')
hpax = gca;
[hts] = LS_Both_ReconstructTimeStamp(hpax.XTick');
hpax.XTickLabels = hts;

subplot(2,1,2)
vp = plot(t,delta_theta_y,'.','color',[.85 .325 .098]); set(gca,'fontsize',12); axis([min(t) max(t) ylims]); 
title('Vertical Tilt'); ylabel('\Delta\theta_y (mrad)'); xlabel('Timestamp')
vpax=gca;
[vts] = LS_Both_ReconstructTimeStamp(vpax.XTick');
vpax.XTickLabels = vts;