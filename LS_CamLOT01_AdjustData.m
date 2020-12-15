%istart is beginning of hour of data
%iend is end of hour of data

%-----Adjust Data-----%
function [Adjhdata,Adjvdata,t] = LS_CamLOT01_AdjustData(a,b,camLOT01)

xtemp=camLOT01(a:b,3);
Adjhdata= xtemp-mean(xtemp);

ytemp=camLOT01(a:b,4);
Adjvdata=ytemp-mean(ytemp);

t=camLOT01(a:b,2);
end



