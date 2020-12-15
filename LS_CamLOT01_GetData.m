%[BuffNum Time Xpos Ypos Xvolts Yvolts Area] 
timestamp=[];

Dec = 4;     %Decimation # (4x4 pix -> 1 pix)
ps =  6e-3;  % (mm / decimated pixel)

hMLOT01= .06;  %Horizontal Magnification
vMLOT01 = .059;

istart = 1; %index within data array to start
iend =size(data,1);  %index to end
%iend = 55800;

m=2;
n=1;


for i =istart:iend

    temp=data(i,13);
    temp2=cell2mat(table2array(temp));
 %   timestamp=vertcat(temp2(1,:),timestamp);
    temp3=split(temp2(1:12),':');
    time(n,1) = str2num(cell2mat(temp3(1))) + 60^-1*str2num(cell2mat(temp3(2))) + 60^-2*str2num(cell2mat(temp3(3))); 
    %ts(i,1) = 60*str2num(temp2(1)) + str2num(temp2(4:7));
    
    n=n+1;
end

xLOT01=table2array(data(:,15))-table2array(data(:,17));
yLOT01=table2array(data(:,16))-table2array(data(:,18));

camLOT01=[table2array(data(1,21)) time(1) ps/hMLOT01*(Dec*(xLOT01(1)-.5)+.5) ps/vMLOT01*(Dec*(yLOT01(1)-.5)+.5) table2array(data(1,2)) table2array(data(1,3))];
%ts28 = timestamp(istart,:);

for j=2:size(time,1)
    if time(j) > time(j-1)
        
        camLOT01(m,1) = table2array(data(j,12));
        camLOT01(m,2) = time(j);
        camLOT01(m,3) = ps/hMLOT01*(Dec*(xLOT01(j)-.5)+.5);
        camLOT01(m,4) = ps/vMLOT01*(Dec*(yLOT01(j)-.5)+.5);
        camLOT01(m,5) = table2array(data(j,2));
        camLOT01(m,6) = table2array(data(j,3));
        
        %ts28 = vertcat(timestamp(j,:),ts28);
        m=m+1;
    end
end
