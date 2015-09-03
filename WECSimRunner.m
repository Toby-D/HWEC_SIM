% WEC-Sim Runner
clear;clc;close all
Ts=(1:0.5:12);
Hs=ones(1,length(Ts));

for rkk=1:length(Ts)
    waves = waveClass('regularCIC');
waves.H = Hs(rkk);                          %Wave Height [m]
waves.T = Ts(rkk);                            %Wave Period [s]

wecSim

save(['HWEC, H=' num2str(Hs(rkk)) ' m, T=' num2str(Ts(rkk)) ' s.mat'])

end