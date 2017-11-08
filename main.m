
clear; close all
tic
patchsize=41;
load('D_Tdatanew_train.mat')
load('D_Fdatanew_train.mat')
inputimage = 'test.png';

imgsize=[768 1024];
multiply=patchsize/16;
holdstep=0.01;
intestep=0.001;
coreff=[0.09 0.19 0.72];
power1=1.6;
power2=3.5;

distMatrix = getdistMatrix(imgsize(1), imgsize(2));
butter_mask = make_butter_rect(imgsize(2), imgsize(1), imgsize(2)*0.35, imgsize(1)*0.35, 10);
my_image = double(imread(inputimage))./256;

inputsize = size(my_image);
my_image = imresize(my_image,imgsize);
sailencymap1=[];
sailencymap2=[];


ps1=round(imgsize(1)/multiply);
ps2=round(imgsize(2)/multiply);

my_image3=imresize(my_image,[ps1 ps2],'bilinear');

imgsizenew=[ps1 ps2];
lb=[7 7];
ub=[8 8];
		
param.K=16*16*4; % learns a dictionary with 100 elements
param.lambda=1.2/16;
param.numThreads=-1; % number of threads
param.verbose=false;
param.iter=1000; % let us see what happens after 1000 iterations.
skipstep=2;% For speeding up

countrow=0;
countcol=0;
for centrow=1:skipstep:imgsizenew(1)
	countrow=countrow+1;
    countcol=0;
	for centcol=1:skipstep:imgsizenew(2)
		countcol=countcol+1;
		if(centrow>lb(1)&centrow<=(imgsizenew(1)-ub(1))&centcol>lb(2)&centcol<=(imgsizenew(2)-ub(2)))
			tempmat=my_image3((centrow-lb(1)):(centrow+ub(1)),(centcol-lb(2)):(centcol+ub(2)));
			meantemp=round(mean(mean(tempmat)));
			tempmat=tempmat-meantemp;
			temp=reshape(tempmat,16*16,1);
			X=temp;
			X=X-repmat(mean(X),[size(X,1) 1]);
			X=X ./ repmat(sqrt(sum(X.^2)),[size(X,1) 1]);
			x_test=X;
	
			alpha_T=mexLasso(x_test,D_T,param);
			reconstructerro_T=sum((x_test-D_T*alpha_T).^2);
			R_T=0.5*sum((x_test-D_T*alpha_T).^2)+param.lambda*sum(abs(alpha_T));

			alpha_F=mexLasso(x_test,D_F,param);
			reconstructerro_F=sum((x_test-D_F*alpha_F).^2);
			R_F=0.5*sum((x_test-D_F*alpha_F).^2)+param.lambda*sum(abs(alpha_F));
			
			sailencymap1(countrow,countcol)=reconstructerro_F-reconstructerro_T;
		else
			sailencymap1(countrow,countcol)=1000;
		end
	end
end


mapmin=min(min(sailencymap1));
sailencymap=sailencymap1-mapmin;
sailencymap(sailencymap1>=900)=0;
mapmax=max(max(sailencymap));
sailencymap=sailencymap/mapmax;
sailencymap=imresize(sailencymap,imgsize,'bilinear');


fix_x = imgsize(1)/2; fix_y = imgsize(2)/2;
lum_pred_map = lum_prediction(my_image,fix_x,fix_y);
rms_pred_map = rms_prediction(my_image,fix_x,fix_y);
lum_pred_map = lum_pred_map./max(lum_pred_map(:));
rms_pred_map = rms_pred_map./max(rms_pred_map(:));


saliencyMap = imfilter(sailencymap, fspecial('gaussian', 8*3, 3*3));
saliencyMap=imfilter(saliencyMap, fspecial('gaussian', 8*3, 3*3));
saliencyMap2=saliencyMap.^power1;
saliencyMap2=saliencyMap2./max(saliencyMap2(:));
saiencymap_final=saliencyMap2*coreff(3)+rms_pred_map*coreff(2)+lum_pred_map*coreff(1);
saiencymap_final=saiencymap_final.^power2;
saiencymap_final=saiencymap_final.*distMatrix;

saiencymap_final = imresize(saiencymap_final,inputsize);
saiencymap_final=saiencymap_final./max(saiencymap_final(:));


imshow(saiencymap_final)
imwrite(saiencymap_final, 'heatmap.jpg')
toc





