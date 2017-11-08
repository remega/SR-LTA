clear;close all;
load('data_tough_neg_train8.mat')%%The extracted training patchs.
load('data_tough_pos_train8.mat')
start_spams
X_T=X_T(:,1:4:size(X_T,2));
X_F=X_F(:,1:4:size(X_F,2));
% eita=[0 0.005 0.01 0.015 0.02 0.025 0.03];
eita=0.05;
num=length(eita);


[nt, Tt] = size(X_T);
patchsize=sqrt(nt);
lengthdic=patchsize*patchsize*4;
oneMat = ones(nt,1);
out =raised_cos_best(patchsize);
outline=reshape(out,patchsize*patchsize,1);

P1=randperm(Tt,lengthdic);
P2=randperm(Tt,lengthdic);

	D_T=[];
	A_T=zeros(lengthdic,lengthdic);
	B_T=zeros(nt,lengthdic);
	D_T=X_T(:,P1);	
	D_F=[];
	A_F=zeros(lengthdic,lengthdic);
	B_F=zeros(nt,lengthdic);
	D_F=X_F(:,P2);	

    


param.mode = 2;   
param.lambda = (1.2/patchsize);      %  l1 norm minimization.
param.numThreads = -1;
coef_T=[];
coef_F=[];
count=1;
count2=1;


for t = 1:Tt
	 if(mod(t,1000)==1)
         T=toc
         fprintf('sparsity level: %d\n',nnz(coef_T)); 
        tic
      end
   iterNum = 1;
   for it = 1:iterNum
   % for i=1:num
   
       param.lambda = (1.2/patchsize)*1.3;  
        % X_ac = patch - oneMat*mean(patch);      
        coef_T = mexLasso( X_T(:,t), D_T, param);
      
        param.lambda = (1.2/patchsize)/1.3;  
        coef_F = mexLasso( X_F(:,t), D_F, param);

		% updating.
        A_T= A_T + coef_T*coef_T';
        B_T= B_T + X_T(:,t)*coef_T';
       
       
        A_F= A_F + coef_F*coef_F';
        B_F= B_F + X_F(:,t)*coef_F';
  
        % Dictionary update column by column
        for iter = 1:2
            for j = 1:lengthdic
                if (A_T(j,j))
                    u1 = (B_T(:,j) - D_T*A_T(:,j))/A_T(j,j);
					u = u1+ D_T(:,j)+eita*(outline*outline'*D_T(:,j));
                    D_T(:,j) = u/max(norm(u),1);
                end
                         
                
                 if (A_F(j,j))
                    u1 = (B_F(:,j) - D_F*A_F(:,j))/A_F(j,j);
					u = u1+ D_F(:,j)-eita*(outline*outline'*D_F(:,j));
                    D_F(:,j) = u/max(norm(u),1);
                end
                
                
            end
        end
   end  
   % end
end  


save('DICs.mat' ,'D_T','D_F');


