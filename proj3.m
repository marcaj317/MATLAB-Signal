load 'fugue.mat';

Fs = 11025; %Sampling Frequency
v1 = (voice(1).start(length(voice(1).start))) + (voice(1).duration(length(voice(1).duration)));
v2 = (voice(2).start(length(voice(2).start))) + (voice(2).duration(length(voice(2).duration)));
v3 = (voice(3).start(length(voice(3).start))) + (voice(3).duration(length(voice(3).duration)));

X = [v1; v2; v3];
mat = uint32(max(X) * Fs + 1);
y = zeros(1, mat);

for i = 1:3
    for j = 1:length(voice(i).start)
        [s, sample] = signal(voice(i).pitch(j),voice(i).duration(j), Fs);
        C = voice(i).start(j) * Fs + 1;
        A = uint32(C);
        B = A + sample - 1;
        y(A:B) = y(A:B) + s;
    end
end

y = y / abs(max(y));
sound(y);

audiowrite('fugue.wav', y, Fs);
information = audioinfo('fugue.wav');
fprintf('Total = %d\n', information.TotalSamples);
fprintf('Rate = %d\n', information.SampleRate);
