clc;clear all;close all;
xl=0;xr=10;yb=0;yt=10;
plot([xl xr],[0,0],'k',[0,0],[yb yt],'k');
xlist=[];ylist=[];
button=1;k=0;
while(button~=3)    %�������һ�����ֹ����
    [xnew,ynew,button]=ginput(1);  %get one mouse click
    if button==1    %������һ��
        k=k+1;
        xlist(k)=xnew;ylist(k)=ynew;  %�����µ����ݵ�
        plot(xlist,ylist,'.',[xl,xr],[0,0],'k',[0,0],[yb,yt],'k');
        axis([xl xr yb yt]);
    end
end
T(:,1)=xlist;T(:,2)=ylist;T;