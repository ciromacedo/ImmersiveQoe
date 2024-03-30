function [Res1,Res2,Res3,Res4] = disanzhangtu(PthR, PkRper)

A1 = dlmread(".\gd.txt");
A2 = dlmread(".\predall.txt");
A3 = dlmread(".\experiment.txt");
A3 = A3+1;
% A3(A3==-0)=0;
% A3(A3==-1)=nan;
%% 生成attention矩阵
usernum = 24;
Atemp=[];
for k = 1: length(A3(usernum,:))
    if A3(usernum,k)>=0
        Atemp(k) = A3(usernum,k);
    end
end

uoal = [];
uoalpre = [];
cixu = [];

for k = 1:length(Atemp)
    uoal(k) = A1(usernum,Atemp(k)); % 用户对不同的object的attention
    uoalpre(k) = A2(usernum,Atemp(k)); % 预测的用户对不同的object的attention
end

numO = length(Atemp); % �?次虚拟旅游中object的�?�数

%% 初始化rendering power
%PthR = 15; % 每个object�?小的渲染功率
PkR = PkRper*numO; % 分配给用户k�?次虚拟元宇宙服务的�?�的渲染功率

PnkR = zeros(1,length(uoal)); % 初始化分配给每个object的功�?

%% 均匀分配策略
PnkR = (PkR-PnkR)/numO + PnkR;
Res1 = sum(uoal.*log(PnkR./PthR));

%% 随机分配策略
Rp = [];
cishu = 100;
for l = 1:cishu
    PnkR = zeros(1,length(uoal)); % 初始化分配给每个object的功�?
    p = 1; i = 1;
    for j = 1:PkR-PthR*length(PnkR)
        while p == 1
            t = rand(1);
            if t < 1/40
                PnkR(i) = PnkR(i) + 1;
                p = -1;
            end
            if i < length(PnkR)
                i = i + 1;
            else
                i = 1;
            end
        end
        p = 1;
    end
    PnkR = PnkR + PthR;
    Rp(l) = sum(uoal.*log(PnkR./PthR));
end
% max(Rp)
% min(Rp)
Res2 = mean(Rp);

%% Optimial Allocation Pre
uxing = sum(uoalpre)/PkR;
PnkR = uoalpre./uxing;
j = 1; t1 = []; t2 = [];
while min(PnkR)<PthR %当不满足�?少的rendering power也要大于PthR�?
    [a,b] = min(PnkR); % a记录了最小的renderning power,b记录了对应的位置
    t1(j) = b;
    t2(j) = uoalpre(b); % �?小的renderning power 对应位置的attention值记录为t2(j)
    uxing = (sum(uoalpre)-sum(t2))/(PkR - PthR*j); %求解新的u*: 分子减去被化成PthR的位置的attention�?,分母是�?�功率减去被归化了的�?
    PnkR = uoalpre./uxing;
    for q = 1:j
        PnkR(t1(q)) = PthR;
    end
    j = j+1;
    %     sum(PnkR)
end
Res3 = sum(uoal.*log(PnkR./PthR));

%% Optimial Allocation GT
uxing = sum(uoal)/PkR;
PnkR = uoal./uxing;
j = 1;
t1 = [];t2 = [];
while min(PnkR)<PthR %当不满足�?少的rendering power也要大于PthR�?
    [a,b] = min(PnkR); % a记录了最小的renderning power,b记录了对应的位置
    t1(j) = b;
    t2(j) = uoal(b); % �?小的renderning power 对应位置的attention值记录为t2(j)
    uxing = (sum(uoal)-sum(t2))/(PkR - PthR*j); %求解新的u*: 分子减去被化成PthR的位置的attention�?,分母是�?�功率减去被归化了的�?
    PnkR = uoal./uxing;
    for q = 1:j
        PnkR(t1(q)) = PthR;
    end
    j = j+1;
    %     sum(PnkR)
end
Res4 = sum(uoal.*log(PnkR./PthR));
end


