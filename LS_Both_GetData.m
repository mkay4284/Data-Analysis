%[BuffNum Time Xpos Ypos Xvolts Yvolts Area] 
timestamp=[];

DecLOT01 = 4;
Dec28 =4;     %Decimation 

ps =  6e-3;  % (mm / decimated pixel)

hMLOT01 = .06;
vMLOT01 = .059;

hM28 = .057;  %Horizontal Magnification
vM28 = .050;

istart = 1; %index within data array to start
iend =size(data,1);  %index to end
%iend = 55800;

mLOT01=2;
m28=2;
nLOT01=1;
n28=1;




for i =istart:iend

    tempLOT01=data(i,13);
    temp2LOT01=cell2mat(table2array(tempLOT01));
    temp3LOT01=split(temp2LOT01(1:12),':');
    timeLOT01(nLOT01,1) = str2num(cell2mat(temp3LOT01(1))) + 60^-1*str2num(cell2mat(temp3LOT01(2))) + 60^-2*str2num(cell2mat(temp3LOT01(3))); 
    nLOT01=nLOT01+1;
    
    temp28=data(i,4);
    temp228=cell2mat(table2array(temp28));
    temp328=split(temp228(1:12),':');
    time28(n28,1) = str2num(cell2mat(temp328(1))) + 60^-1*str2num(cell2mat(temp328(2))) + 60^-2*str2num(cell2mat(temp328(3))); 
    n28=n28+1;
    
end

xLOT01=table2array(data(:,15))-74;
yLOT01=table2array(data(:,16))-64;
x28=table2array(data(:,6))-86.5;
y28=table2array(data(:,7))-60.25;

camLOT01=[table2array(data(1,21)) timeLOT01(1) ps/hMLOT01*(DecLOT01*(xLOT01(1)-.5)+.5) ps/vMLOT01*(DecLOT01*(yLOT01(1)-.5)+.5) table2array(data(1,2)) table2array(data(1,3))];
cam28=[table2array(data(1,12)) time28(1) ps/hM28*(Dec28*(x28(1)-.5)+.5) ps/vM28*(Dec28*(y28(1)-.5)+.5) table2array(data(1,2)) table2array(data(1,3))];


for j=2:min([size(timeLOT01,1) size(time28,1)])
    if timeLOT01(j) > timeLOT01(j-1) && time28(j) > time28(j-1)
        
        camLOT01(mLOT01,1) = table2array(data(j,12));
        camLOT01(mLOT01,2) = timeLOT01(j);
        camLOT01(mLOT01,3) = ps/hMLOT01*(DecLOT01*(xLOT01(j)-.5)+.5);
        camLOT01(mLOT01,4) = ps/vMLOT01*(DecLOT01*(yLOT01(j)-.5)+.5);
        camLOT01(mLOT01,5) = table2array(data(j,2));
        camLOT01(mLOT01,6) = table2array(data(j,3));
        
        cam28(m28,1) = table2array(data(j,12));
        cam28(m28,2) = time28(j);
        cam28(m28,3) = ps/hM28*(Dec28*(x28(j)-.5)+.5);
        cam28(m28,4) = ps/vM28*(Dec28*(y28(j)-.5)+.5);
        cam28(m28,5) = table2array(data(j,2));
        cam28(m28,6) = table2array(data(j,3));
        
        mLOT01=mLOT01+1;
        m28=m28+1;
    end
end
