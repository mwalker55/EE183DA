clear; clc;

%initialize current position and goal position
currXYT_est = [0; 0; 0];
currXYT_true = [0; 0; 0];
goalXYT = [1; 1; 0];
num_iter = 0;

%initialize empty matrices to hold trajectories for demonstration at end
est_path = zeros(2,1);
tru_path = zeros(2,1);

%assume we are currently not close enough to goal position
close_enough = false;

while ~close_enough&& num_iter < 30
   %generate control sequence between current estimated position and goal
   %position
   control_seq = generateTrajectory(currXYT_est, goalXYT);
   %implement resulting control sequence and estimate states
   [tru, est] = estimator(control_seq, currXYT_true, currXYT_est);
   %update path and position variables
   est_path = horzcat(est_path, est(1:2,:));  tru_path = horzcat(tru_path, tru(1:2,:));
   currXYT_est = est(1:3, end);  currXYT_true = tru(1:3, end);
   %check if we think we are close enough
   if ismembertol(currXYT_est, goalXYT, .0001)
       close_enough = true;
   end
   num_iter = num_iter+1;
end


%plot trajectories followed
figure; hold on;
plot(est_path(1,:), est_path(2,:));
plot(tru_path(1,:), tru_path(2,:));
plot(goalXYT(1), goalXYT(2), 'r*');
plot(0, 0, 'b*');
legend('Estimated', 'True', 'Goal Point', 'Starting Point');

%compute distance between true endpoint and goal endpoint
dist = pdist([currXYT_true(1:2)'; goalXYT(1:2)'], 'Euclidean');