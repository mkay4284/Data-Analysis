%istart is beginning of hour of data
%iend is end of hour of data

%-----Adjust Data-----%
function [Adjhdata,Adjvdata,t] = LS_Cam28_AdjustData(a,b,cam28)

xtemp=cam28(a:b,3);
Adjhdata= xtemp-mean(xtemp);

ytemp=cam28(a:b,4);
Adjvdata=ytemp-mean(ytemp);

t=cam28(a:b,2);
end



