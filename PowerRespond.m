function [Pr,db]=PowerRespond(ckt,Rload,Rsource,f)
w=2*pi*f; %w is angular frequency
I=ones(size(w));
V=ones(size(w))*Rload;%set up arrays for inputI(f) and V(f)
ckt_index=0; 
morecompsflag=1;

while morecompsflag == 1 %loop through string of components
ckt_index=ckt_index+1; %ckt_index prepared for next item in list
component=ckt{ckt_index};
morecompsflag=1-strcmp(component,'EOF'); %zero after last component
if strcmp(component,'PC')==1
ckt_index=ckt_index+1; capacitance=ckt{ckt_index};
I=I+V.*(1j.*w.*capacitance);
elseif strcmp(component,'SC')==1
ckt_index=ckt_index+1; capacitance=ckt{ckt_index};
V=V+I./(1j.*w.*capacitance);
elseif strcmp(component,'PL')==1
ckt_index=ckt_index+1; inductance=ckt{ckt_index};
I=I+V./(1j.*w.*inductance);
elseif strcmp(component,'SL')==1
ckt_index=ckt_index+1; inductance=ckt{ckt_index};
V=V+I.*(1j.*w.*inductance);
elseif strcmp(component,'PR')==1
ckt_index=ckt_index+1; resistance=ckt{ckt_index};
I=I+V/resistance;
elseif strcmp(component,'SR')==1
ckt_index=ckt_index+1; resistance=ckt{ckt_index};
V=V+I*resistance;
end %components loop
end %frequency loop

V=V+I.*Rsource;
Pr=Rload./((abs(V).^2)/(4.*Rsource));%Power Respond
db=10/log(10)*log(Pr);
end