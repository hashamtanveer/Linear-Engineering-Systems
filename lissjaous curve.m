t = 0 : 0.01 : 2*pi; % 2*pi allows the fill command to work.
y1 = 3*sin(4*t);
subplot(3, 2, 1) % start with tile #1
plot(t, y1, 'r', 'LineWidth', 3) % plot y1 against t in red.
%set(gca,'fontsize', 18); % make the font bigger
grid on
title('y1(t)') % place a title on this subplot.
axis([0 2*pi -3.25 3.25]), yticks(-3:1:3)
xlabel('t')

t = 0 : 0.01 : 2*pi; % 2*pi allows the fill command to work.
y2 = 4*sin(3*t);
subplot(3, 2, 2) % start with tile #1
plot(t, y2, 'b', 'LineWidth', 3) % plot y1 against t in red.
grid on
title('y1(t)') % place a title on this subplot.
axis([0 2*pi -3.25 3.25]), yticks(-3:1:3)
xlabel('t')

subplot(3,2, 3:6)
plot(y1, y2 ,'k', 'LineWidth', 3)
grid on
title('Lissajous Curve')
axis([0 2*pi -3.25 3.25]), yticks(-3:1:3)
xlabel('y1')
ylabel('y2')
hold on 
fill(y1, y2, 'magenta')
plot(y1(1), y2(1), 'bp', 'MarkerFaceColor', 'yellow', 'MarkerSize', 20) 
axis equal tight

