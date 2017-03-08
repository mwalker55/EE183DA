#Lab 5
This folder constitutes Team Velma's submission for Lab 5 of EE183DA Winter 2017 taught by Professor Ankur Mehta.
##Methods
This lab is largely adapted from [lab 4](https://github.com/mwalker55/EE183DA/tree/master/lab4).  There is an addition of a trajectory planner and trajectory controller, the operation of which is briefly discussed here.  The state estimator code was also changed from a script to a function in order to better fit the framework of the trajectory controller.

###Trajectory Controller
At a high level, the trajectory controller takes in a endpoint for the robot to be in - an x,y position and theta orientation.  Assuming that the robot begins at the middle of the table facing right (x=0, y=0, theta=0), the robot will iteratively use the trajectory planner until the state estimator shows that the robot's three operational state variables are within 1% of the goal (this tolerance was chosen to still provide a fairly accurate result while also preventing the control loop from running an excessively large number of times).  This occurs as follows:  
-use trajectory planner to find trajectory from current position to goal position  
-implement control sequence given by trajectory planner  
-run state estimator to determine new estimated position  
-if within 1% of goal position, done  
-if not within 1% of goal position, repeat from top using new estimated position
###Trajectory Planner
The trajectory planner takes in both the current position and goal position.  It then generates a three step control sequence:  
-rotation needed to point from current position to goal position  
-forward linear motion from current position to goal position once pointed  
-rotation to theta specified in goal position

For each of the three steps, we assume ideal speeds both in rotation and linear motion (i.e. the wheels rotate at exactly 65RPM).  The number of 2ms cycles needed for these are computed by dividing the amount of rotation/linear motion needed at each step by the ideal rotation/linear distance completed in 2ms and rounding to the nearest integer.  Thus, the trajectory planner will rarely provide a perfect method of moving to the desired endpoint since it has a 2ms resolution.  Furthermore, the wheels will likely not spin at exactly 65RPM, introducing further error.  These two sources of error are the reason that the trajectory controller must repeat the process of generating a trajectory multiple times - the result will likely not be good enough after the first iteration.  
##Results
The table below shows four values.  The first column contains a graph showing the trajectory followed between the origin and the desired endpoint, with both the state estimated and true trajectories shown.  The next two columns provide the desired endpoint and the true endpoint (not the state estimation output), given in the form (x,y,theta).  The last column shows the linear distance between the desired endpoint and the true endpoint in meters.  
