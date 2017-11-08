
function out =raised_cos_best(WINDOW_SIZE)

[X Y] = meshgrid(-WINDOW_SIZE/2:WINDOW_SIZE/2-1,-WINDOW_SIZE/2:WINDOW_SIZE/2-1);
X=X+0.5;
Y=Y+0.5;
R = (X.^2+Y.^2).^0.5;

H=reshape(R,1,WINDOW_SIZE*WINDOW_SIZE);
[H2,index]=sort(H);
count=1;
count2=0;
while(count<=WINDOW_SIZE*WINDOW_SIZE)
	L=length(find(H2==H2(1,count)));
	H2(1,count:count+L-1)=count2;
	count=count+L;
	count2=count2+1;
end
H4=zeros(1,WINDOW_SIZE*WINDOW_SIZE);
for i=1:WINDOW_SIZE*WINDOW_SIZE
	H4(1,index(i))=H2(i);
end
H5=reshape(H4,WINDOW_SIZE,WINDOW_SIZE);

PATCH_RADIUS =  max(H5(:));
H6=cos(H5*pi/PATCH_RADIUS);


H7=reshape(H6,1,WINDOW_SIZE*WINDOW_SIZE);
[H8,index]=sort(H7);
count=1;
while(count<=WINDOW_SIZE*WINDOW_SIZE)
	L=length(find(H8==H8(1,count)));
	H8(1,count:count+L-1)=H8(1,count:count+L-1)/L;
	count=count+L;
end
H9=zeros(1,WINDOW_SIZE*WINDOW_SIZE);
for i=1:WINDOW_SIZE*WINDOW_SIZE
	H9(1,index(i))=H8(i);
end
H10=reshape(H9,WINDOW_SIZE,WINDOW_SIZE);

out=H10*4;

end