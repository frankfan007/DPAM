% ���������������ܶ������ܶ�
kcluster={};
 Den=[];
%     fprintf('final-----clustering------ \n');
    ite=0;
    k=unique(idx);
for k=unique(idx)'
    kk=find(idx==k);
      sum=0;
    ite=ite+1;
    kcluster{ite}=kk;
    D1 = pdist(T(kk,:)); %ŷʽ����
    DM1=squareform(D1);%��D��ԭΪ�������
    for j=1:length(kk)-1
        sum=sum+DM1(j,j+1);
    end
    Den(ite,:)=(length(kk)/size(data,1))*sum/length(kk); % �����ܶȼ��㷽ʽ
    
end