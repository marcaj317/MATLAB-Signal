function [x, t] = signal(pitch, duration, fs)

Ts = 1/fs; 
F = 440*2^((pitch-49)/12);
t = 0:Ts:duration;
x = cos(2 * pi * F.*t);
y = ones(1,length(x));

fadeI = linspace(0,1,100);
fadeO = linspace(1,0,100);
y(1:100) = fadeI;
y(length(y)-99:length(y)) = fadeO;
x = x.*y;
t = length(x);
end 