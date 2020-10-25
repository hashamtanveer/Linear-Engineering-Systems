function [r]=rotate(angle_in_deg)
 d=angle_in_deg
 r=[cosd(d) -sind(d) 0; sind(d) cosd(d) 0; 0 0 1];
end

