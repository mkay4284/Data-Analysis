%---- TOP-LEVEL PROGRAM TO PROCESS DATA -----%
%This script requires cam28 and istart/iend 
%(defining the valid data range) to be in workspace

%------------ GLOBAL DECLARATIONS -----------%
L=66000;                            %path length (mm)
mmlim = [-10 10];                   %axis limits (mm)
mradlim = [1e3*atan(mmlim/L)];      % ''    ''   (mrad)
uradlim = 1e3 * mradlim;            % ''    ''   (urad)


%------------- FUNCTION CALLS ---------------%
[TimeStamps] = LS_Cam28_ReconstructTimeStamp(cam28(:,2));
[Adjhdata,Adjvdata,t] = LS_Cam28_AdjustData(istart,iend,cam28);
LS_Cam28_Drift_SpectrumPlots(Adjhdata,Adjvdata,t,mmlim,uradlim,L);