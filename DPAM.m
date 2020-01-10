% CMAD is a three stage clustering algorithm,
% it does not depend on whether there are reasonable parameters,
% and get accurate and robust results.
% written by Yizhang Wang 2017
% 2017 03 23
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;clear;close all
addpath('D:\MEGAFile\work\evaluation', 'D:\MEGAFile\work\Complicate','D:\MEGAFile\work\UCI','D:\MEGAFile\work\drawGraph');
addpath('D:\MEGAFile\work\Celldata');
load('iris.mat');
% load('E:\MEGAFile\work\Complicate\Jain.mat');


T=data;
Row = size(T,1);
Col = size(T,2);
D = pdist(T); %ŷʽ����
DM=squareform(D); %��D��ԭΪ�������
S=-DM;
%% ƫ�����������
N=size(S,1); %����ĸ���
meds = max(S(:));            %S(:)�ǽ�S����任��һ��ʸ����Ȼ�����median����ȡ��ֵ
mins= mean(min(S(:)));
find (S==mins)
for i = 1:N
     S(i,i)=0.1*mins; %S(i,i)��ֵѡȡ�Ծ��ྫ��������Ҫ
  %  S(i,i)=0.05*mins; %S(i,i)��ֵѡȡ�Ծ��ྫ��������Ҫ
end
%% A(i,k)��R(i,k)��Ϣ����
ar_update
%% Sil��Ч��ָ�꼰������
result;
%% ���ap����ͼ
% Ex_evaluation
drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% �ڶ��׶Σ������������ͼ
oldidx=c;
iter=0;
Den=[];
oldDen=0;%��¼��һ������ľֲ��ܶ�
icluster=[];
for i=unique(idx)'
    sum=0;
    iter=iter+1;
    ii=find(idx==i);%iiÿ��������
    icluster{iter}=ii;
end
iclen=length( icluster);
oldcluster=[1:iclen];
temp=oldcluster(1);%temp�洢��ǰ�����
iter=0;
%% �ϲ��׶�
bigcluster=[icluster{temp}];%�洢��ǰ�ϲ�����
while ~isempty(oldcluster)
    iter=iter+1;
    temp_DM=DM;%�ֲ����ƶ�
    %  fprintf('---------------------------------------\n');
    % ������뱾�������һ�������ڵ���
    %% ������������������һ�࣬sminEdu����̾���
    icluster{temp};
    bigcluster;% 1�����Ѿ��ϲ���������һ����������̾���.2����һ��������Ҳ���Ծ�������������һ���������
    irow=temp_DM(icluster{temp},:);%irow�ǵ�j�����е������ƶȾ����е�������
    %irow�е�j���������ĵ���̵ľ���
    irow(:,[bigcluster])=inf;
    [Y U]=min(irow,[],2);
    [Y1 U1]=min(Y) ;   %    U1 �Ǳ����������ݵ����
    newdat=oldidx(U(U1));  %    newdat����һ������ݵ����
    sminEdu=Y1;
    %% �����֮����̾����е����ֵ��omaxEdu������������
    D2 = pdist(T(icluster{temp},:));
    DM2=squareform(D2); %��D��ԭΪ�������
    %   DM2 (DM2==0)=inf;%��DM�����е�0Ԫ�ر�����
    %omaxEdu�Ǳ����У�ÿһ���������������̾��룬ѡ���ġ�
    Dm2i=max(DM2);
    omaxEdu=max(Dm2i);
    if sminEdu<omaxEdu
        idx(icluster{newdat},:)=min(idx(icluster{temp},:));
        %         fprintf('��%d�� �͵�%d��ϲ� ��%d��ѭ�� \n',temp,newdat,iter);
        %% ���Ϻϲ�Ҫ���Ĳ���
        oldcluster(temp)=0;
        bigcluster=[bigcluster
            icluster{newdat}];
        temp = newdat;
    else
        %         fprintf('��%d�� �Ͽ���%d��ѭ��  \n',temp,iter);
        oldcluster(temp)=0;
        pp=find(oldcluster~=0);
        if isempty (pp)
            break;
        end
        temp=pp(1);
    end
end
% Ex_evaluation
drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% �����׶�  ������վ���
if isequal(var(Den),0)
    return;
end
ys=0
for i=1:1000
    GetDesi;
    save{i}=idx
    fprintf('��%d��ѭ�� %d \n',i,length(unique(idx)));
    var(Den)
    if isequal(var(Den),0)
        idx=save{i-1};
        ys=1;
        break;
    else
        Getshortedu;       
    end
    if ys==1
        break;
    end
end
%% ����ָ��
%sil=mean(silhouette(T,c))
%% ����¾���ͼ
% drawAP
 set(gca,'looseInset',[0 0 0 0]);
%% �ⲿ����ָ��
Evaluation(label,idx);
