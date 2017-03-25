[y, fs] = audioread('snare2.wav');
y = y(:,1);
dt = 1/fs;

y2 = 2*y;
len = length(y);
% for j = 1:1:1000
%    y(j+9000) = y(i + 5000); 
% end

for i = 1:1:1000
  y(i + 5000) = y(i+4000);
  y(i + 6000) = y(i+4000);
  y(i + 7000) = y(i+4000);
  y(i + 8000) = y(i+4000);

end
t = 0:dt:(length(y) * dt)- dt;
plot(t, y);
xlabel('Seconds');
ylabel('Amplitude');