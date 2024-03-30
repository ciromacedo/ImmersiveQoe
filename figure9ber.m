clc;clear;
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

% Pkdb = 10; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
% Pk = 10^(Pkdb/10);
% 璋冨埗鏂瑰紡
a=1;
b=0.5;
%%
Pkdb = 0:5:40; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
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
    BEP1(i)=mean((gamma(b).*(1-gammainc(a*Y,b)))/(2*gamma(b)));
end

%% USER2
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

% Pkdb = 10; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
% Pk = 10^(Pkdb/10);
% 璋冨埗鏂瑰紡
a=1;
b=0.5;
%%
Pkdb = 0:5:40; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
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
    BEP2(i)=mean((gamma(b).*(1-gammainc(a*Y,b)))/(2*gamma(b)));
end

%% user3
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

% Pkdb = 10; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
% Pk = 10^(Pkdb/10);
% 璋冨埗鏂瑰紡
a=1;
b=0.5;
%%
Pkdb = 0:5:40; % 鍙戝皠鍔熺巼鐨勫ぇ灏?
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
    BEP3(i)=mean((gamma(b).*(1-gammainc(a*Y,b)))/(2*gamma(b)));
end

%%
BM1=[0.465374, 0.438607, 0.391836, 0.313119, 0.194973, 0.0672565, 0.00586499, 0.0000319068, 2.3324*10^-9];
BM2=[0.461, 0.430906, 0.37857, 0.291762, 0.167032, 0.0471406, 0.00264186, 6.5681*10^-6, 1.75312*10^-10];
BM3=[0.420284, 0.360397, 0.263135, 0.131988, 0.0263159, 0.000583262, 1.35975*10^-7, 1.44611*10^-14, 5.06657*10^-17];

%%

semilogy(Pkdb,BEP1,'r*');hold on;
semilogy(Pkdb,BEP2,'b*');hold on;
semilogy(Pkdb,BEP3,'m*');hold on;

semilogy(Pkdb,BM1,'r-');hold on;
semilogy(Pkdb,BM2,'b--');hold on;
semilogy(Pkdb,BM3,'m:.');hold on;

axis([0 40 1e-6 max(BM1)])

grid on;

