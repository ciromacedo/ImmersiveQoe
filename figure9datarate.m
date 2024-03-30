% clc;clear;
Num = 1e6;
MC = 6;
MU = 3; 
NQ = 3;
Pp = 5; % 
mupdb = -3; % 
mup = 10^(mupdb/10); %
mukdb = -1; % 
muk = 10^(mukdb/10); %
Dkj = 10; % 
akj = 2; % 
% 
% MC = 6; % CBS的天线
% MU = 3; % 用户渲染服务器的天线
% NQ = 3; % 干扰路径的数量
% Pp = 5; % 干扰功率的强度
% mupdb = -3; % 干扰径的衰落
% mup = 10^(mupdb/10); %
% mukdb = -1; % 信号径的衰落
% muk = 10^(mukdb/10); %
% Dkj = 10; % 大尺度 传输距离
% akj = 2; % 大尺度衰落

% Pkdb = 10; % 发射功率的大小
% Pk = 10^(Pkdb/10);

%%
Pkdb = 0:5:40; % 发射功率的大小
Pk = 10.^(Pkdb./10);
for i = 1:length(Pk)
    ttep = 500;
    zeta = 0;
    tep = ttep;
    while tep ~= 0
        sig = muk*Pk(i)*Dkj^(-akj);
        TH = random('Normal',0,sqrt(sig),MC*MU);
        TH = TH'*TH;
        eg = eig(TH);
        zeta = zeta + max(eg)/sum(eg);
        tep = tep - 1;
    end
    zeta = zeta/ttep;
    DELK = (Pp*mup)/(MC*zeta*muk*Pk(i)*Dkj^(-akj));
    Y =  Fisher(MC,MU,NQ,DELK,Num);
    R1(i) = mean(log2(1+Y));
end
%% Line 2 
MC = 6; % CBS的天线
MU = 3; % 用户渲染服务器的天线
NQ = 3; % 干扰路径的数量%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pp = 5; % 干扰功率的强度
mupdb = -1; % 干扰径的衰落
mup = 10^(mupdb/10); %
mukdb = -2; % 信号径的衰落
muk = 10^(mukdb/10); %
Dkj = 6; % 大尺度 传输距离
akj = 2; % 大尺度衰落
Pkdb = 0:5:40; % 发射功率的大小
Pk = 10.^(Pkdb./10);
for i = 1:length(Pk)
    ttep = 500;
    zeta = 0;
    tep = ttep;
    while tep ~= 0
        sig = muk*Pk(i)*Dkj^(-akj);
        TH = random('Normal',0,sqrt(sig),MC*MU);
        TH = TH'*TH;
        eg = eig(TH);
        zeta = zeta + max(eg)/sum(eg);
        tep = tep - 1;
    end
    zeta = zeta/ttep;
    DELK = (Pp*mup)/(MC*zeta*muk*Pk(i)*Dkj^(-akj));
    Y =  Fisher(MC,MU,NQ,DELK,Num);
    R2(i) = mean(log2(1+Y));
end

%% Line 3
MC = 6; % CBS的天线
MU = 7; % 用户渲染服务器的天线
NQ = 3; % 干扰路径的数量
Pp = 1; % 干扰功率的强度
mupdb = -3; % 干扰径的衰落
mup = 10^(mupdb/10); %
mukdb = -1; % 信号径的衰落 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
muk = 10^(mukdb/10); %
Dkj = 10; % 大尺度 传输距离
akj = 2; % 大尺度衰落
Pkdb = 0:5:40; % 发射功率的大小
Pk = 10.^(Pkdb./10);
for i = 1:length(Pk)
    ttep = 500;
    zeta = 0;
    tep = ttep;
    while tep ~= 0
        sig = muk*Pk(i)*Dkj^(-akj);
        TH = random('Normal',0,sqrt(sig),MC*MU);
        TH = TH'*TH;
        eg = eig(TH);
        zeta = zeta + max(eg)/sum(eg);
        tep = tep - 1;
    end
    zeta = zeta/ttep;
    DELK = (Pp*mup)/(MC*zeta*muk*Pk(i)*Dkj^(-akj));
    Y =  Fisher(MC,MU,NQ,DELK,Num);
    R3(i) = mean(log2(1+Y));
end
%% Mathematic
RM1 = [0.0055949, 0.0176102, 0.0548871, 0.166209, 0.467179, 1.13174, 2.23747, 3.66233, 5.23891];
RM2 = [0.00778252, 0.0244516, 0.0757943, 0.226058, 0.613786, 1.40658, 2.62255, 4.10557, 5.70485];
RM3 = [0.0278384, 0.0861157, 0.255371, 0.684287, 1.53497, 2.79763, 4.30406, 5.91223, 7.55606];


%%
plot(Pkdb,R1,'r*');hold on;
plot(Pkdb,R2,'b*');hold on;
plot(Pkdb,R3,'m*');hold on;

plot(Pkdb,RM1,'r-');hold on;
plot(Pkdb,RM2,'b--');hold on;
plot(Pkdb,RM3,'m:.');hold on;

grid on


