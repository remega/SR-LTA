clear all;close all;

 load('testpatch_data.mat')
L=length(testpatch);

x_test=[];

for i=1:L

	temp1=testpatch{i};
	temp3=round(imresize(temp1,[24 24]));
	temp=reshape(temp3,24*24,1);
	x_test=[x_test temp];

end
