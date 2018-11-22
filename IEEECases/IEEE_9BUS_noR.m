function mpc = IEEE_9BUS
%CASE9    Power flow data for 9 bus, 3 generator case.
%   Please see CASEFORMAT for details on the case file format.
%
%   Based on data from Joe H. Chow's book, p. 70.

%   This file is taken from MATPOWER available at http://www.pserc.cornell.edu/matpower/
%  R. D. Zimmerman, C. E. Murillo-S�nchez, and R. J. Thomas,
%  "MATPOWER: Steady-State Operations, Planning and Analysis Tools for Power Systems Research and Education," 
%  Power Systems, IEEE Transactions on, vol. 26, no. 1, pp. 12-19, Feb. 2011.

%% MATPOWER Case Format : Version 2
mpc.version = '2';

%%-----  Power Flow Data  -----%%
%% system MVA base
mpc.baseMVA = 100;

%% bus data
%	bus_i	type	Pd	Qd	Gs	Bs	area	Vm	Va	baseKV	zone	Vmax	Vmin
mpc.bus = [
1	3	0   0	0	0	1	1	0	11	1	1	0.9; % grid
2	1	150	20	0	0	1	1	0	11	1	1.1	0.9;
3	1	100 20	0	0	1	1	0	11	1	1.1	0.9;
4	1	140	30	0	0	1	1	0	11	1	1.1	0.9;
5	1	150	30	0	0	1	1	0	11	1	1.1	0.9;
6	1	80	20	0	0	1	1	0	11	1	1.1	0.9;
7	1	60  20	0	0	1	1	0	11	1	1.1	0.9;
8	1	75	20	0	0	1	1	0	11	1	1.1	0.9;
9	1	90  20	0	0	1	1	0	11	1	1.1	0.9;
10	1	130	30	0	0	1	1	0	11	1	1.1	0.9;
];
%     10 BASE_KV     baseKV, base voltage (kV)
%% generator data
%	bus	Pg	Qg	Qmax	Qmin	Vg	mBase	status	Pmax	Pmin	Pc1	Pc2	Qc1min	Qc1max	Qc2min	Qc2max	ramp_agc	ramp_10	ramp_30	ramp_q	apf
mpc.gen = [
	1	0	0	5	-5	1	100	1	10	0	0	0	0	0	0	0	0	0	0	0	0;
    %10	0.03	0.005	50	-50	1	100	1	100	0	0	0	0	0	0	0	0	0	0	0	0;
];

%% branch data
%	fbus	tbus	r	x	b	rateA	rateB	rateC	tap ratio	angle(shift)	status	angmin	angmax
mpc.branch = [
1	2	0.5	0.4127	0	0	0	0	0	0	1	-360	360;
2	3	0.5	0.6057	0	0	0	0	0	0	1	-360	360;
3	4	0.5	1.205	0	0	0	0	0	0	1	-360	360;
4	5	0.5	0.6084	0	0	0	0	0	0	1	-360	360;
5	6	0.5	1.7276	0	0	0	0	0	0	1	-360	360;
6	7	0.5	0.7886	0	0	0	0	0	0	1	-360	360;
7	8	0.5	1.164	0	0	0	0	0	0	1	-360	360;
8	9	0.5	2.716	0	0	0	0	0	0	1	-360	360;
9	10	0.5	3.0264	0	0	0	0	0	0	1	-360	360;
];
%%
mpc.bus_name = {
	'Grid';
	'BUS NO1';
	'BUS NO2';
	'BUS NO3';
	'BUS NO4';
	'BUS NO5';
	'BUS NO6';
	'BUS NO7';
	'BUS NO8';
	'BUS NO9';
};
%%-----  OPF Data  -----%%
%% generator cost data
%	1	startup	shutdown	n	x1	y1	...	xn	yn
%	2	startup	shutdown	n	c(n-1)	...	c0
mpc.gencost = [
    2	0      0	3	0    250	 0;
]; % 80$/MWh
%% convert branch impedances from Ohms to p.u.
mpc.Vbase = mpc.bus(1,10)*10^3; % in Volts 11,000
mpc.Sbase = mpc.baseMVA * 1e6; % in VA 10e6
mpc.branch(:, [3, 4]) = mpc.branch(:, [3, 4]) / (mpc.Vbase^2 / mpc.Sbase);
%% convert loads from kW to MW and kVAR to MVAR
mpc.bus(:, [3, 4]) = mpc.bus(:, [3, 4]) / 1e3;
