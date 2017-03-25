[y, fs] = audioread('snare2.wav');
y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y) * dt)- dt;
[y2, fs2] = audioread('hihat.wav');
y2 = y2(:,2);
dt2 = 1/fs2;
t2 = 0:dt:(length(y2) * dt2) - dt2;
plot(t,y, 'b', t2, y2, 'r');
xlabel('Seconds');
ylabel('Amplitude');
% figure
% plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));
y3 = y(1:length(y2));
yy = y3 + y2;
figure()
plot(t2,yy);
xlabel('Seconds');
ylabel('Amplitude');
soundsc(yy);