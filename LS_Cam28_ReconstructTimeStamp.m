function [TimeStamps] = LS_Cam28_ReconstructTimeStamp(time)

h = floor(time);

m = floor(60*rem(time,h));

s = 60 * rem(60*rem(time,h),floor(60*rem(time,h)));

temp1 = num2str(h);
temp2 = num2str(m);
temp3 = num2str(s);

for i = 1:size(h,1)
 temp4(i,:) = horzcat(temp1(i,:),':',temp2(i,:));
 
 if sum(isspace(temp4(i,:))) > 0
     temp4(i,find(isspace(temp4(end,:)))) = '0';
 end
 
 TimeStamps(i,:) = horzcat(temp4(i,:),' PM');
end
end