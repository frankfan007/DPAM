% �����������������С�����ľ��󣬲����¼���ͷ����ǩ
for j=1:length(Den)
    for k=1:length(Den)
        irow=temp_DM(kcluster{j},kcluster{k});%irow�ǵ�j�����е������ƶȾ����е�������
        [Y U]=min(irow,[],2);% Y ÿһ�е���Сֵ
        [Y2 U2]=min(Y);  %    U1 �Ǳ����������ݵ����
        short(j,k)=Y2;
    end
end
maxmean=find(Den>mean(Den));
short=short(:,find(Den>mean(Den)));
short(short==0)=inf;
[Y3 U3]=min(short,[],2);% Y ÿһ�е���Сֵ
for j=1:length(Den)
    if Den(j)<mean(Den)
%         kcluster{maxmean(U3(j))}
        idx(kcluster{j},:)=idx(kcluster{maxmean(U3(j))}(1));
    end
end