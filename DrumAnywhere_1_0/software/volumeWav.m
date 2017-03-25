[y, fs] = audioread('snare2.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y) * dt)- dt;
y2 = 2*y;

plot(t,y2, 'b', t, y, 'r');
xlabel('Seconds');
ylabel('Amplitude');