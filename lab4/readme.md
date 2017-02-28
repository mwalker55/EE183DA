#State Estimation of a Two-Wheeled Car
This is the webpage for Team Velma's submission for lab 4 of EE183DA Winter 2017, taught by Professor Ankur Mehta.
##Introduction
In this lab, we consider a small, two-wheeled car controlled by a microcontroller.  A sample car fitting this description is shown in figure 1.<br>
![alt text][car]<br>
*figure 1: sample small, two-wheeled car (image courtesy of lab 4 specifications)*<br>
This car is driven by two continuous servos, one for each wheel.  Each servo is driven by a pulse-width modulation (PWM) input from the on-board microcontroller.  When the servos are driven, the state of the vehicle, consisting of the x,y coordinate relative to some origin of the car, its rotation relative to some axis, and the time derivatives of those three values, changes.  Our goal in this lab is to be able to measure the state of the vehicle as accurately as possible given the inputs sent to the servos as well as noisy sensor data that provides a partial understanding of the vehicle state.
##Simulation
Rather than physically construct this small, two-wheeled car, our team chose to simulate its operation.  This simulation operates simply at a high level: receive PWM inputs, add some noise to these inputs, use the noisy PWM inputs to generate the actual RPM speed and direction of each servo, and lastly model the sensing of the RPM/direction data.  
###Sensing
The original lab specification provides for IR sensors attached to each servo that produce a HIGH/LOW signal based on the position of the wheel, which had twenty alternating white/black colored circular sectors.  We found that this was not an ideal sensing solution for state estimation; a discussion on this is included later in this report.<br>
Instead of the IR sensor, our group decided to simulate the use of a rotary encoder.  A rotary encoder provides a measure of both the RPM of the shaft it is attached to (after some simple processing) as well as the direction of shaft rotation.  The rotary encoder we chose to simulate can measure 2500 pulses per revolution, meaning that it can measure to the nearest .0004 of a rotation of the attached shaft.  We chose to simulate the presence of a rotary encoder on each servo output shaft, giving us an RPM for each wheel.
###PWM Inputs
The two servos on the vehicle take in a PWM signal and then process the input signal into rotational motion.  We consider the PWM frequency of our system to be 500Hz, meaning that each PWM period is exactly 2ms.  Per the 

[car]: http://i.imgur.com/DzEnqye.png
