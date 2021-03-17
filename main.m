clear;
clc;

data=xlsread('Butterworth.xlsx');
startfreq=0; 
endfreq=2/(2*pi); 
freqstep= 0.0001/pi;
f=(startfreq:freqstep:endfreq);
Rsource=1;
N=10;

value=data(N,:);

ckt=zeros(1,N);
ckt=num2cell(ckt);

ckt1=zeros(1,2*N+1);
ckt1=num2cell(ckt1);

Rload=value(:,N+1);
value=value(:,1:N);
value=fliplr(value);

for it=1:N
    if mod(it,2) ~= 0
        ckt{:,it}='PC';
    else
        ckt{:,it}='SL';
    end
    ckt1{:,2*it-1}=ckt{:,it};
    ckt1{:,2*it}=value(:,it);
end

ckt1{:,2*N+1}='EOF';

[Prcurve,db]=PowerRespond(ckt1,Rload,Rsource,f);

w=2*pi.*f;
plot(w,Prcurve,'r');
grid;
xlabel('Angular Frequency');ylabel('Power Respond');



