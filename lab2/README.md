#Arduino Drum System
##Introduction
This is the Github page for the Arduino drum system based on the ESP8266 made for EE183DA Winter 2017 at UCLA taught by Professor Ankur Mehta.
##Mechanical Description
The system mechanically is simple to setup.  Attach an object to a rotor arm on a standard servo and place it a small distance from an object which it will strike against.  A sample picture is shown below.<br><br>
![alt text][setup]<br>
*figure 1: picture of set up drum system on standard servo*<br><br>
By default, the servo should be plugged into the D6 voltage, ground and PWM plug.  You will need some object to hit the drum stick against to generate noise - I used a soda can.  There is also a question of mounting the servo close to the object - I held it with my hand, but an actual mount is preferable.
##Bill of Materials
-1 ESP8266 Microcontroller<br>
-1 ESP8266 Motor Shield<br>
-Micro-USB Cable<br>
-1 Standard Micro Servo<br>
-1 Servo Rotor Arm<br>
-1 Metal Bracket<br>
-Electrical tape<br>
-1 Empty Soda Can
##Operation
Operation of the drum system is simple.  Assemble the system as shown in figure 1, connect the servo to D6, and upload lab2.ino (found at the head of this repository) to the ESP8266.  A wifi network named "mark" should appear.  Connect to it with password "12345678".

In a web browser, enter as a URL 192.168.4.1/index.  You will be greeted with a welcome screen introducing you the Arduino drum system.  A dropdown menu will let you navigate to the three functions of the drum, which I will detail below.
###Manual Control
![alt text][manual_control]<br>
*figure 2: screenshot of manual control page*<br><br>
This page allows you to manually control the drum.  If you press the "Drum" button, the servo will rotate to strike your drum target.
###Beat Sequencer
![alt text][beat_sequencer]<br>
*figure 3: screenshot of beat sequencer page*<br><br>
This page allows you to order together five pre-made beats into a cohesive song.  By hitting "Add Beat X", you will add beat X to your current combination of beats; the page should update to show the new beat added.  "Remove Last" well take off the beat most recently added to combination.  "Clear All" will remove all beats in the current combination.  "Play" will send the combination to the drum which will then perform it.

Note: the pre-made beats can be changed by altering functions beat1() to beat5() in lab2.ino.  The functions work by calling strike() (which causes the drum to strike) mixed with delay() calls to set a tempo.
###Pre-made Songs
![alt text][pre_made_song]<br>
*figue 4: screenshot of pre-made song page*<br><br>
This page allows you to play the five pre-made songs made using the beats described above.  If you find a combination of beats in the synthensizer that you like, you can copy it to one of the functions song1() to song5() by calling the corresponding beat1() etc. functions to save it for future use.
##Demonstration
The below video demonstrates the Arduino drum system in action.  In the video, one of the pre-made songs is being played by the drum.  The drum is hitting against a soda can in the video.

[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/40Gdmw4ancg/0.jpg)](http://www.youtube.com/watch?v=40Gdmw4ancg)

##Possible Improvements
This system can be improved in a few ways.  For one, it can be extended to allow more than just one drum.  Another area for improvement would be to allow for beat/song creation in the web browser without needing the .ino source to be edited.

[setup]: http://i.imgur.com/vAXYMOV.png
[manual_control]: http://i.imgur.com/YlN8rpv.png
[beat_sequencer]: http://i.imgur.com/GvSQ58R.png
[pre_made_song]: http://i.imgur.com/HuOIVDN.png
