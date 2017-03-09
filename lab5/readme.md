#Lab 5
This folder constitutes Team Velma's submission for Lab 5 of EE183DA Winter 2017 taught by Professor Ankur Mehta.
##Methods
This lab is largely adapted from [lab 4](https://github.com/mwalker55/EE183DA/tree/master/lab4).  There is an addition of a trajectory planner and trajectory controller, the operation of which is briefly discussed here.  The state estimator code was also changed from a script to a function in order to better fit the framework of the trajectory controller.

###Trajectory Controller
At a high level, the trajectory controller takes in a endpoint for the robot to be in - an x,y position and theta orientation.  Assuming that the robot begins at the middle of the table facing right (x=0, y=0, theta=0), the robot will iteratively use the trajectory planner until the state estimator shows that the robot's three operational state variables are within .01% of the goal (this tolerance was chosen to still provide a fairly accurate result while also preventing the control loop from running an excessively large number of times).  This occurs as follows:  
-use trajectory planner to find trajectory from current position to goal position  
-implement control sequence given by trajectory planner  
-run state estimator to determine new estimated position  
-if within .01% of goal position, done  
-if not within .01% of goal position, repeat from top using new estimated position

We set an arbitrary limit of 30 iterations for this loop to run to prevent the program from running excessively long.
###Trajectory Planner
The trajectory planner takes in both the current position and goal position.  It then generates a three step control sequence:  
-rotation needed to point from current position to goal position  
-forward linear motion from current position to goal position once pointed  
-rotation to theta specified in goal position

For each of the three steps, we assume ideal speeds both in rotation and linear motion (i.e. the wheels rotate at exactly 65RPM).  The number of 2ms cycles needed for these are computed by dividing the amount of rotation/linear motion needed at each step by the ideal rotation/linear distance completed in 2ms and rounding to the nearest integer.  Thus, the trajectory planner will rarely provide a perfect method of moving to the desired endpoint since it has a 2ms resolution.  Furthermore, the wheels will likely not spin at exactly 65RPM, introducing further error.  These two sources of error are the reason that the trajectory controller must repeat the process of generating a trajectory multiple times - the result will likely not be good enough after the first iteration.  
###Obstacles
We consider the only obstacle to be the edges of the table and assume that the user will not select points that are outside of the bounds of the table used.
##Results
The table below shows four values.  The first column contains a graph showing the trajectory followed between the origin and the desired endpoint, with both the state estimated and true trajectories shown.  The next two columns provide the desired endpoint and the true endpoint (not the state estimation output), given in the form (x,y,theta), where x and y are in meters and theta is in radians.  The last column shows the linear distance between the desired endpoint and the true endpoint in meters.  Note that the true endpoint and distances are computed as averages of five trials.

Trajectory | Desired Endpoint | True Endpoint | Error (cm)  
--- | --- | --- | ---  
[1](http://i.imgur.com/JXQcpmg.png) | (-1.53, -0.87, 4.678) | (-1.5863, -0.8626, 4.673) | 5.68
[2](http://i.imgur.com/i8Hk5Jz.png) | (0.556, -0.234, 1.234) | (0.562, -0.2384, 1.225) | 0.68
[3](http://i.imgur.com/T93Fdpp.png) | (1, 0, 3.14) | (1.0124, -5.6E-4, 3.160) | 1.24
[4](http://i.imgur.com/308Wuu0.png) | (-0.5, 0.75, 4.712) | (-0.532, 0.752, 4.7988) | 3.2
[5](http://i.imgur.com/CNv2Rvm.png) | (1.0, 1.0, 0) | (1.044, 0.967, 5.938) | 5.49 

We see that the trajectory planner will generally put the vehicle within a about a 6-7cm radius of where we truly want it to be.  This error is caused by inaccuracy in the state estimator.  It is worth noting that the the error will generally be a function of how far the car had to travel from the origin; as the vehicle moves further and further from the origin, the errors in each step continue to add up.  
