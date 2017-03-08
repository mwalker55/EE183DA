clear; clc;

currXYT_est = [0; 0; 0];
currXYT_true = [0; 0; 0];
goalXYT = [-1.53; -0.87; 4.678];
num_iter = 0;

est_path = zeros(2,1);
tru_path = zeros(2,1);

close_enough = false;

while ~close_enough
   control_seq = generateTrajectory(currXYT_est, goalXYT);
   [tru, est] = estimator(control_seq, currXYT_true, currXYT_est);
   est_path = horzcat(est_path, est(1:2,:));  tru_path = horzcat(tru_path, tru(1:2,:));
   currXYT_est = est(1:3, end);  currXYT_true = tru(1:3, end);
   if((abs(currXYT_est(1)) >= abs(0.99*goalXYT(1))&&abs(currXYT_est(1)) <= abs(1.01*goalXYT(1)))&&(abs(currXYT_est(2)) >= abs(0.99*goalXYT(2))&& abs(currXYT_est(2)) <= abs(1.01*goalXYT(2)))...
           &&(currXYT_est(3) >= 0.99*goalXYT(3) && currXYT_est(3) <= 1.01*goalXYT(3)))
       close_enough = true;
   end
   num_iter = num_iter+1;
end

figure; hold on;
plot(est_path(1,:), est_path(2,:));
plot(tru_path(1,:), tru_path(2,:));
plot(goalXYT(1), goalXYT(2), 'r*');
legend('Estimated', 'True');