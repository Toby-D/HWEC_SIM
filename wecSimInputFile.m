%% Simulation Data
simu = simulationClass();               %Create the Simulation Variable
simu.simMechanicsFile = 'RM3.slx';      %Location of Simulink Model File
simu.endTime=400;                       %Simulation End Time [s]
simu.dt = 0.1;                          %Simulation Time-Step [s]
simu.rampT = 100;                       %Wave Ramp Time Length [s]
% simu.CITime=20;
simu.domainSize=200
simu.rho=1025; 
%% Wave Information
%% noWaveCIC, no waves with radiation CIC  
% waves = waveClass('noWaveCIC'); 

%% Regular Waves  
% waves = waveClass('regularCIC'); 
% waves = waveClass('regular');        
                                 %Create the Wave Variable and Specify Type
                                 
% waves.H = 1.5;                          %Wave Height [m]
% waves.T = 5;                            %Wave Period [s]

%% Irregular Waves using PM Spectrum with Convolution Integral Calculation
% waves = waveClass('irregular');       
%                                %Create the Wave Variable and Specify Type
% waves.H = 2.5;                        %Significant Wave Height [m]
% waves.T = 8;                          %Peak Period [s]
% waves.spectrumType = 'PM';

%% Irregular Waves using BS Spectrum with State Space Calculation
% waves = waveClass('irregular');       
%                                   %Create the Wave Variable and Specify Type
% waves.H = 1.5;                        %Significant Wave Height [m]
% waves.T = 5;                          %Peak Period [s]
% waves.spectrumType = 'BS';
% simu.ssCalc = 0;						%Control option to use state space model 

%% Irregular Waves using User-Defined Spectrum
% waves = waveClass('irregularImport');         
%                                %Create the Wave Variable and Specify Type
% waves.spectrumDataFile = 'ndbcBuoyData.txt';  
%                                   %Name of User-Defined Spectrum File [2,:] = [omega, Sf]

%% User-Defined Time-Series
% waves = waveClass('userDefined');   %Create the Wave Variable and Specify Type
% waves.etaDataFile = 'umpqua46229_6_2008.mat';  % Name of User-Defined Time-Series File [:,2] = [time, wave_elev]

%% Body Data
body(1) = bodyClass('hydroData/HWECprfl_tnydsk.h5',1,0);      
    %Create the body(1) Variable, Set Location of Hydrodynamic Data File 
    %and Body Number Within this File.        
body(1).mass = 32.6644*simu.rho %3.8774e+04; %Not including water entrained in tube. 'equilibrium';                   
    %Body Mass. The 'equilibrium' Option Sets it to the Displaced Water 
    %Weight.
body(1).momOfInertia = [566351.051 566351.051 93560.755]; %Estimate from C:\Users\Toby\Desktop\UNH\Healy Wave Power\WEC-Sim\Geometry\Demo\Buoy.SLDASM
    %Moment of Inertia [kg*m^2]     
body(1).geometryFile = 'geometry/Buoy.stl';    %Location of Geomtry File


body(2) = bodyClass('hydroData/HWECprfl_tnydsk.h5',2,0);     
body(2).mass = 24.2707*simu.rho; % 'equilibrium';                   
body(2).momOfInertia = [1.7327e+05 1.7327e+05 1.2377e+04]; %MMI of water in tube. Calculated in HWEC_parameters.m
body(2).geometryFile = 'geometry/Piston.stl'; 

%% Mooring
mooring.k=zeros(6,6);
mooring.preTension=0;
%% PTO and Constraint Parameters
constraint(1) = constraintClass('Constraint1'); 
                        %Create Constraint Variable and Set Constraint Name
constraint(1).loc = [0 0 0];                    %Constraint Location [m]


pto(1) = ptoClass('PTO1');                      
                                      %Create PTO Variable and Set PTO Name
pto(1).k=522.2256;                                     %PTO Stiffness [N/m] 
pto(1).c=1.1135e+05;                               %PTO Daming [N/(m/s)]  %Computed from skk=2, H=1.5m, T=4.8-4.8s, PTOkk=2, prfixed=1, d_o=0.1016m , d_i=0.0508m , n_i=1,  tend=480.mat
pto(1).loc = [0 0 0];                           %PTO Location [m]





%%