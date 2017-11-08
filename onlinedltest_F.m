function [D A B]=onlinedltest_F(X,D,A,B,newstartflag,eita)




[nt, Tt] = size(X);
patchsize=sqrt(nt);
lengthdic=patchsize*patchsize*4;

if(newstartflag)
	P=randperm(Tt,lengthdic);
	D=[];
	A=zeros(lengthdic,lengthdic);
	B=zeros(nt,lengthdic);
	D=X(:,P);	
end

oneMat = ones(nt,1);
out =raised_cos_best(patchsize);
outline=reshape(out,patchsize*patchsize,1);

param.mode = 2;   
% param.lambda = (1.2/patchsize)/1.3;      %  l1 norm minimization.
param.lambda = (1.2/patchsize)/1.3;
param.numThreads = -1;

count=1;
count2=1;
tic
for t = 1:Tt

   %beta = 0.4; sigma = 1; noise_var = 1;
   %coef(:,t) = l1ls_featuresign(D, X(:,indperm(t)), beta/sigma*noise_var);
   %coef(:,t) = OMPerr( D, X(:,t), epsilon ); 
   %patch = X(:,indperm(t));

   iterNum = 1;
   for it = 1:iterNum
       
        % X_ac = patch - oneMat*mean(patch);      
        coef = mexLasso( X(:,t), D, param);
        % print sparsity level
		if(mod(t,1000)==1)
        fprintf('sparsity level: %d\n',nnz(coef)); 
        end
		% updating.
        A = A + coef*coef';
        B = B + X(:,t)*coef';
        % Dictionary update column by column
        for iter = 1:2
            for j = 1:lengthdic
                if (A(j,j))
                    u1 = (B(:,j) - D*A(:,j))/A(j,j);
					u = u1+ D(:,j)-eita*(outline*outline'*D(:,j));
                    D(:,j) = u/max(norm(u),1);
					% count=count+1;
					% if(count==500)
						% second(:,count2)=outline*outline'*D(:,j);
						% first(:,count2)=u1;
						% expression=mean(abs(second(:,count2)./first(:,count2)))
						% count2=count2+1;
						% count=1;
					% end
					
                end
            end
        end
   end  
 
end  
 T=toc    
%Im_D = displayDictionaryElementsAsImage(D, Pn, Pn, n, K, sortVarFlag)

