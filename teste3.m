% Running the program, get four values:
% 1. Uniform rendering power allocation strategy
% 2. Random rendering power allocation strategy
% 3. Optimial power Allocation (GT) - bound
% 4. Optimial Allocation base on our Predictions
clc;clear;
A1 = dlmread("gd.txt"); % The ground truth
A2 = dlmread("predall.txt"); % Prediction results
A3 = dlmread("experiment.txt");% Randomly generated sparse interactions
% A3 = readmatrix('experiment2.txt');% Randomly generated sparse interactions
A3 = A3+1; % Start with 1
FINAL=zeros(30,5);
RFINAL=zeros(30,5);
Attention = -1.*ones(30,59);
%% Generate attention matrix


%Rosana - parte do RDk e EUk
Rd = [];  %vetorde taxa de downlink
Bep = dlmread("bep.txt");
Eu = [];  %vetor de taxa de BEP de uplink 
cone = [];  %vetor do coeficiente de conexao (KPIs objetivos)

Rd = zeros(1,30);
Eu = zeros(1,30);
cone = zeros(1,30);
for k = 1:30
    Rd(k) = randi([10, 42]);
   %Eu(k)= rand([1e-8,1e-2]);    
   % Eu(k)= rand(0.1);  
end
for i = 1:30
    Rd(i) =  max (Rd)- min (Rd);
    Eu(i) =  max (Eu)- min (Eu);
   % cone(i)= Rd(i) * (1-Eu(i));
     cone(i)= Rd(i) * (1-Bep(i));

end
%%Rosana



for u = 1:30
%usernum = u;% change to try different users (1~30)
usernum = 30;% change to try different users (1~30)

Atemp = [];
for k = 1: length(A3(usernum,:))
    if A3(usernum,k)>=0
        Atemp(k) = A3(usernum,k);             
    end
end

uoal = [];
uoalpre = [];
cixu = [];

for k = 1:length(Atemp)
    uoal(k) = A1(usernum,Atemp(k)); % User attention to different objects (GT)
    uoalpre(k) = A2(usernum,Atemp(k)); % Predicted user attention for different objects
    Attention(usernum,k) = uoal(k);
end

numO = length(Atemp); % Total number of objects in one virtual tour

%% Initialize rendering power
% PthR = 15; % Minimum rendering power per object
% PkR = 1000; % The total rendering power of one virtual metaverse service assigned to user k

PthR = 15;
PkR = numO*20; %maximo de recurso para renderizacao  %PNKR é o recurso usado com cada user

if PthR.*length(Atemp)>PkR
    disp('not availiable');
    finish
end

PnkR = zeros(1,length(uoal)); % Initialize the power assigned to each object

%% Uniform rendering power allocation strategy
PnkR = (PkR-PthR.*numO)/numO + PthR;
PnkR = PnkR.*ones(1,numO);
FINAL(u,2) = sum(uoal.*log(PnkR./PthR));
RFINAL(u,2) = cone(usernum)* sum(uoal.*log(PnkR./PthR));
% sum(PnkR)
%% Random rendering power allocation strategy
PnkR = zeros(1,length(uoal));
Rp = [];
cishu = 40;
for l = 1:cishu
PnkR = zeros(1,numO); % Initialize the power assigned to each object
p = 1; i = 1;
for j = 1:(PkR-PthR*numO)
    while p == 1
        t = rand(1);
        if t < 1/length(Atemp)
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
FINAL(u,1) = mean(Rp);
RFINAL(u,1) = cone(usernum)* mean(Rp);
% sum(PnkR)

%% Optimial Allocation Predictions
PnkR = zeros(1,length(uoal));
uxing = sum(uoalpre)/PkR;
PnkR = uoalpre./uxing;
j = 1;
t1 = [];t2 = [];
while min(PnkR)<PthR 
    [a,b] = min(PnkR); 
    t1(j) = b;
    t2(j) = uoalpre(b); 
    uxing = (sum(uoalpre)-sum(t2))/(PkR - PthR*j); 
    PnkR = uoalpre./uxing; 
    for q = 1:j
    PnkR(t1(q)) = PthR;
    end
    j = j+1;
%     sum(PnkR)
end
FINAL(u,3) = sum(uoal.*log(PnkR./PthR));
RFINAL(u,3) = cone(usernum) * sum(uoal.*log(PnkR./PthR));
% sum(PnkR)

%% Optimial Allocation GT
PnkR = zeros(1,length(uoal));
uxing = sum(uoal)/PkR;
PnkR = uoal./uxing;
j = 1;
t1 = [];t2 = [];
while min(PnkR)<PthR 
% When the condition that the minimum rendering power 
% must be greater than PthR is not satisfied
    [a,b] = min(PnkR); 
    % a records the minimum renderning power,
    % b records the corresponding position
    t1(j) = b;
    t2(j) = uoal(b);
    uxing = (sum(uoal)-sum(t2))/(PkR - PthR*j); %Solve for the new u*
    PnkR = uoal./uxing; 
    for q = 1:j
    PnkR(t1(q)) = PthR;
    end
    j = j+1;
%     sum(PnkR)
end
FINAL(u,4) = sum(uoal.*log(PnkR./PthR));
RFINAL(u,4) = cone(usernum) * sum(uoal.*log(PnkR./PthR));

FINAL(u,5) = cone(usernum) * sum(uoal.*log(PnkR./PthR));
RFINAL(u,5) = cone(usernum) * sum(uoal.*log(PnkR./PthR));

% sum(PnkR)

end


%% Plot

% FINAL=[FINAL;mean(FINAL)];
% wzi = 14;
% bar(FINAL);grid on;
% axis([0 32 0 75])
% xlabel('Metaverse Users')
% ylabel('Meta-Immersion (QoE)')
% legend('Random power allocation','Uniform power allocation','Semantic-aware power allocation','Upper-bound')
% set(gca,'fontname','Times New Roman','FontSize',wzi);
% Diff1 = (FINAL(:,3)-FINAL(:,2))./FINAL(:,2);%
% Diff2 = (FINAL(:,4)-FINAL(:,3))./FINAL(:,3);% 
% 
% mean(Diff1')
% mean(Diff2')
% disp([Diff1'.*100])
% Diff2'.*100




% FINAL=[FINAL;mean(FINAL)];
% wzi = 12;
% %plot(FINAL,'o-');
% bar(FINAL);grid on;
% axis([0 32 0 75])
% %axis([0 5 0 75])
% xlabel('Metaverse Users')
% ylabel('Meta-Immersion (QoE)')
% legend('Random power allocation','Uniform power allocation','Semantic-aware power allocation','Upper-bound', 'COM KPIS')
% set(gca,'fontname','Times New Roman','FontSize',wzi);
% Diff1 = (FINAL(:,3)-FINAL(:,2))./FINAL(:,2);%
% Diff2 = (FINAL(:,4)-FINAL(:,3))./FINAL(:,3);% 
% 
% mean(Diff1')
% mean(Diff2')
% disp([Diff1'.*100])
% Diff2'.*100





RFINAL=[RFINAL;mean(RFINAL)];
wzi = 12;
plot(FINAL,'o-');
bar(RFINAL);grid on;
axis([0 32 0 1450])
%axis([0 5 0 75])
xlabel('Metaverse Users')
ylabel('Meta-Immersion (QoE) com KPIs')
legend('Random power allocation','Uniform power allocation','Semantic-aware power allocation','Upper-bound')
set(gca,'fontname','Times New Roman','FontSize',wzi);
Diff1 = (RFINAL(:,3)-RFINAL(:,2))./RFINAL(:,2);%
Diff2 = (RFINAL(:,4)-RFINAL(:,3))./RFINAL(:,3);% 

mean(Diff1')
mean(Diff2')
disp([Diff1'.*100])
Diff2'.*100
%disp(Diff2'.*100)
%xticklabels(user_labels);




