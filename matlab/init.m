Controls_Plant;

use_skyhook = 0;
use_random = 0;

cs_s = 7.5;
cs_p = 1.5;

Gd_n0 = 256e-6;
n0 = 0.1;
w = 2;

n_min = 0.02;
n_max = 4.0;
N = 600;
n = linspace(n_min, n_max, N).';
dn = (n_max - n_min)/N

V = 20;  T = 10;
fs = 1000;
t = (0:1/fs:T).';

A = sqrt(2 * (Gd_n0*(n/n0).^(-w)) * dn);
rng(1);
phi = 2*pi*rand(N,1);

w_i = 2*pi*n*V;
P = w_i*t.' + phi;
z = (A.' * cos(P)).' * 1000;
zr_r = [t, z];

t = [0.4; 0.5; 0.6; 0.7];
z = [0; 0; 10; 10];
zr_s = [t, z];