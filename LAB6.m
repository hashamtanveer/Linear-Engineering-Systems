 xcoords =[0 1 2 3 2 3 2 1 0]; 
 ycoords =[2 1 1 2 5/2 3 4 4 3];
 zcoords = ones(1,9);
 
 pacman = [xcoords; ycoords; zcoords];
 
 fill(xcoords,ycoords,'yellow','LineWidth',4);
 
 xlabel('x')
 ylabel('y')
 title('Pacman')
 hold on
 plot(2,3.25,'ko','markerfacecolor','k','markersize',20)
 
 translate = @(dx,dy) [1 0 dx; 0 1 dy; 0 0 1];
 translate(3,5)*[5; 8; 1]
 
 rotate=@(d)[cosd(d) -sind(d) 0; sind(d) cosd(d) 0; 0 0 1];
 v1 = rotate(30) * rotate(60) * [7;24;1]
 v2 = rotate(90) * [7;24;1]


 
 x_maze1 = [0 25 25 0 0 15 15 5 5 20 20 0];
 y_maze1 = [0 0 25 25 10 10 15 15 20 20 5 5];
 fill(x_maze1,y_maze1,'cyan','linewidth',4)
 axis([-5 30 -5 30]);
 title('Pacman Maze')
 xlabel('x');
 ylabel('y');
 
 x_maze = [ x_maze1(1:6) x_maze1+30 x_maze1(7:12)];
 y_maze = [ y_maze1(1:6) y_maze1+10 y_maze1(7:12)];
 fill(x_maze,y_maze,'cyan','linewidth',4)
 
 
 x_maze2 = [ x_maze1(1:6) x_maze+30 x_maze1(7:12)];
 y_maze2 = [ y_maze1(1:6) y_maze+10 y_maze1(7:12)]; 
 fill(x_maze2,y_maze2,'cyan','linewidth',4)
 x_maze3 = [ x_maze1(1:6) x_maze2+30 x_maze1(7:12)];
 y_maze3 = [ y_maze1(1:6) y_maze2+10 y_maze1(7:12)]; 
 fill(x_maze3,y_maze3,'cyan','linewidth',4)
 f1 = figure() % Handle for a new figure
 mymap = [winter; parula; jet; hsv]; % Combine more than one colormap for exotic effects
 colormap(mymap)
 % Enlarge figure to almost full screen.
 set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.1, 0.1 0.9, 0.9])
 % Plot your maze using fill and the fancy custom colormap named mymap
 Cfill = rand(size(x_maze3)); % random color fill using the colormap
 fill(x_maze3, y_maze3, Cfill, 'LineWidth', 2, 'EdgeColor', 'red')
 hold on % we will add more items soon.
 % Fine tune the axes
 ax = gca; ax.Color = [0, 0, 0.4]; % dark blue background
 axis equal tight
 axis([-5, 120, -5, 60])
 set(gca, 'Color', 'black')
 
 TP = [22.5 22.5 2.5 2.5;2.5 22.5 22.5 12.5];
 TP = [TP TP + [30;10]]; 
 TP = [TP TP + 2 * [30;10]];
 plot(TP(1,:),TP(2,:),'h','MarkerSize',16,'markerfacecolor','yellow','markeredgecolor','blue' )
 pacman_handle = fill(pacman(1,:),pacman(2,:),'y', 'LineWidth', 2);
 black_jewel_handle = plot(105,42.5,'d','MarkerFacecolor','black','Markersize',20); 
 % add 24 bonus jewels
jewel_locations = [ 12.5 22.5 22.5 12.5 2.5 12.5;2.5 7.5 17.5 22.5 17.5 12.5]; % the six jewels in loop 1
jewel_locations = [ jewel_locations jewel_locations + [30;10]]; % 6 more jewels in loop 2
jewel_locations = [ jewel_locations jewel_locations + 2*[30;10]];
jewel_locations = [ jewel_locations jewel_locations + 3*[30;10]];
% Add 12 more jewels in loops 3 and 4
% Just repeat the last line but using 2*[30;10]] instead.
% Bonus depends on color of each jewel

jewel_colors = ["red", "blue", "green", "magenta", "yellow", "cyan"];
jewel_colors = [jewel_colors jewel_colors jewel_colors jewel_colors]; % repeats four times

jewels = [] % vector of handles for each jewel plot
% Plot all the bonus jewels using a for loop
for n = 1:numel(jewel_colors)
 x = jewel_locations(1,n); y = jewel_locations(2,n);
 h = plot(x, y, 'd', 'MarkerSize', 14, 'MarkerFaceColor', jewel_colors(n));
 jewels = [jewels, h];
end
% Add a display message near the bottom
text(40, 0, 'Jewels:', 'FontSize', 20, 'Color', 'red' )


filename1 = "pacman_beginning.wav"
filename2 = "pacman_intermission.wav"
[music1,Fs1] = audioread(filename1);
[music2,Fs2] = audioread(filename2); 







clc, axis("off")
f1.Color = [0, 0, 0.4];
dx = 0.5; dy = 0.0;% Pacman starts out moving directly to the right.
current_pacman = pacman;
pacman_center = [1.5; 2.5]; % center point of the Pacman figure
score = 0; % points awarded for gobbling jewels
void = [22.5 ; 12.5]; voids = [void void+[30;10] void+[60;20]]; % the three voids
jewel_count = 0; % number of jewels gobbled down by PACMAN
for i =1:1000 % This is more than enough moves.
 current_pacman = translate(dx, dy) * current_pacman;
 pacman_center = pacman_center + [dx; dy];

 % Handle bonus jewels (excludes the final black jewel)
 [~,index] = ismember(pacman_center',jewel_locations','rows');
 if index > 0
 jewel = jewels(index);
 x = jewel_locations(1, index); y = jewel_locations(2, index);
 jewel_color = jewel.MarkerFaceColor;
 score = score + 10*sum(jewel_color);
 fprintf('Found a %s jewel at location [%.1f, %.1f] Reward: + %d\n', jewel_colors(index), x, y, 10*sum(jewel_color))
 pacman_handle.FaceColor = jewel_color;
 title_message = strcat("PACMAN SCORE: ", int2str(score) );
 title(title_message, 'Color', 'magenta')
 jewel_count = jewel_count + 1;
 plot(60 + 5*mod(jewel_count-1,6), 5* floor((jewel_count-1)/6), 'd', 'MarkerSize', 14, 'MarkerFaceColor', jewel_color);
 delete(jewel)
 pause(0.4) % extra time delay when a jewel is gobbled
 end
 pause(0.1) % Time delay to create the illusion of an animation.
 delete(pacman_handle)

 % Students just need to add code here for crossing the void.
 % Pacman earns 100 points on each crossing of the voids
 if ismember(pacman_center', voids', 'rows')
     score = score + 100
     title_message = strcat("PACMAN SCORE: ", int2str(score) );
     title(title_message,'Color','magenta')
     fprintf('Reward for crossing the void: +100 points\n')
     sound(music1,Fs1);
     pause(0.4) % extra time delay when a void is crossed
 end

 % Handle the turning points.
 % First check if Pacman has arrived at a turning point, all of which
 % are stored in the array TP. If yes, rotate counter-clockwise by 90
 % degrees.

 if ismember(pacman_center',TP','rows');
 % Rotate direction of motion 90 degress counter-clockwise
 new_direction = rotate(90) * [dx; dy; 1];
 dx = new_direction(1); dy = new_direction(2);

 % Rotate Pacman 90 degrees counter-clockwise
 x = pacman_center(1); y = pacman_center(2); % Get pacman coordinates.
 current_pacman = translate(x, y)*rotate(90)*translate(-x, -y) * current_pacman;
 pacman_handle = fill(current_pacman(1, :), current_pacman(2, :), 'yellow', 'LineWidth', 2);
 % Handle finding the large black jewel. End of the game! Success!!!
 elseif isequal(pacman_center, [105; 42.5])
 % DONE!! SUCCESS!! Pacman found the magic BLACK jewel!
 score = 2 * (score + 50); % Instant 50 points. Then entire score is doubled!
 fprintf('Magic black crystal doubles your score to %d\n',score )
 delete(black_jewel_handle)
 pacman_handle = fill(current_pacman(1, :), current_pacman(2, :), 'yellow', 'LineWidth', 2);
 title_message = strcat('CONGRATULATIONS! SCORE DOUBLED: ', {' '}, int2str(score));
 title(title_message, 'Color', 'magenta')
 fprintf('Congratulations! Pacman has found the magic BLACK crystal and won his eye!\n')
 eye = [0.5; 0.75] + pacman_center; % Give Pacman an eye as a reward!
 plot( eye(1),eye(2), 'bo', 'MarkerFaceColor', 'black', 'MarkerSize', 4)
 break % Game Over!
 else
 pacman_handle = fill(current_pacman(1, :), current_pacman(2, :), 'yellow', 'LineWidth', 2);
 end
end
 
 % Have Pacman flash to celebrate victory!
for n = 1:21 % Flash 21 times
 pause(0.1) % Time delay to create the illusion of flashing.
 delete(pacman_handle)
 if mod(n,2)==0
 pacman_handle = fill(current_pacman(1, :), current_pacman(2, :), 'blue', 'LineWidth', 2);
 else
 pacman_handle = fill(current_pacman(1, :), current_pacman(2, :), 'yellow', 'LineWidth', 2);
 end
 plot( eye(1),eye(2), 'bo', 'MarkerFaceColor', 'blue', 'MarkerSize', 4) % Redraw the eye
end

 
sound(music2,Fs2);
 
 
 