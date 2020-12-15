%[BuffNum Time Xpos Ypos Xvolts Yvolts Area] 
timestamp=[];

Dec = 4;     %Decimation # (4x4 pix -> 1 pix)
ps =  6e-3;  % (mm / decimated pixel)

hM28 = .057;  %Horizontal Magnification
vM28 = .050;

istart = 1; %index within data array to start
iend =size(data,1);  %index to end
%iend = 55800;

m=2;
n=1;


for i =istart:iend

    temp=data(i,4);
    temp2=cell2mat(table2array(temp));
 %   timestamp=vertcat(temp2(1,:),timestamp);
    temp3=split(temp2(1:12),':');
    time(n,1) = str2num(cell2mat(temp3(1))) + 60^-1*str2num(cell2mat(temp3(2))) + 60^-2*str2num(cell2mat(temp3(3))); 
    %ts(i,1) = 60*str2num(temp2(1)) + str2num(temp2(4:7));
    
    n=n+1;
end

x28=table2array(data(:,6))-table2array(data(:,8));
y28=table2array(data(:,7))-table2array(data(:,9));

cam28=[table2array(data(1,12)) time(1) ps/hM28*(Dec*(x28(1)-.5)+.5) ps/vM28*(Dec*(y28(1)-.5)+.5) table2array(data(1,2)) table2array(data(1,3))];
%ts28 = timestamp(istart,:);

for j=2:size(time,1)
    if time(j) > time(j-1)
        
        cam28(m,1) = table2array(data(j,12));
        cam28(m,2) = time(j);
        cam28(m,3) = ps/hM28*(Dec*(x28(j)-.5)+.5);
        cam28(m,4) = ps/vM28*(Dec*(y28(j)-.5)+.5);
        cam28(m,5) = table2array(data(j,2));
        cam28(m,6) = table2array(data(j,3));
        
        %ts28 = vertcat(timestamp(j,:),ts28);
        m=m+1;
    end
end
