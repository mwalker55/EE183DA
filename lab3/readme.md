#Team Velma's ESP-8266 Instrument Jam Band
##Introduction
This jam band powered by the ESP-8266 constitutes Team Velma's submission for lab 3 of EE183DA Winter 2017.
##Construction
First, construct the three constiuent instruments:<br>
1. [Mark's Arduino Drum](https://github.com/mwalker55/EE183DA/tree/master/lab2)<br>
2. [Joel's Drum](https://github.com/jpark6694/EE-183DA-LAB-2-Electromechanical-Musical-Instrument-)<br>
3. [Sumedh's Drum](https://github.com/sumedhvijay/Drum)<br>
Joel's drum will act as the reference drum for the jam band.  For sensing it for Mark's drum, attach the vibration sensor to the bottom of the drum stick as shown in figure 1.<br>
![alt text][vib_s_attach]<br>
*figure 1: vibration sensor taped onto arm of Joel's drum*<br>
Attach this vibration sensor into the circuit diagram shown in figure 2, using the 5V source, A0 and GND from Mark's drum's ESP8266.  In implementing the diagram, use the vibration sensor as the switch.<br>
![alt text][vib_s_diagram]<br>
*figure 2: circuit diagram for vibration sensor*<br>
On the base that Joel's drum strikes against, attach a LED on one side of the point that the drum strikes and attach a photoresistor on the other end as shown in figure 3.<br>
![alt text][photo_attach]<br>
*figure 3: LED and photoresistor opposite from one another at strike point*<br>
Attach the LED and photoresistor into the following two circuits shown in figure 4, using the 5V source on Sumedh's drum's ESP8266 as Vcc and setting VOUT2 to be A0 on Sumedh's drum's ESP8266.<br>
![alt text][photo_circuit]<br>
*figure 4: circuit diagrams for LED and photoresistor*<br>
For the Arduino sketches, Joel's remains unchanged from the sketch found in the link above.  For Mark's drum, use the mark_drum.ino sketch found in this repo and for Sumedh's drum use the sumedh_drum.ino sketch found in this repo.
##Theory of Operation
###Vibration Sensor
The vibration sensor attached to Joel's drum's arm serves as a switch as shown in the circuit diagram in figure 2 above.  When Joel's drum is stationary, the vibration sensor serves as an open switch and thus the analog output value is high.  When Joel's drum is in motion, the vibration sensor serves as a closed switch and thus the analog output value drops.  These changes were calibrated for control purposes and are shown in table in figure 5.<br>
![alt text][vib_s_table]<br>
*figure 5: calibration table for vibration sensor*<br>
When the analogRead() value is detected to have dropped significantly, Joel's drum is in motion and thus Mark's drum activates itself for a few hits to back Joel's drum's beat (motion is sensed multiple times).<br>
###Photoresistor
When Joel's drum stick moves between the LED and photoresistor, the photoresistor's resistance drops, leading to an increase in the voltage across the 10K ohm resistor and thus an increase in the value of analogRead().  Due to a reading delay, we calibrated there to be a delay between the spike in the output voltage of the circuit and the actual motion of the arm (output voltage is read to be higher some time after the arm moves).  We calibrated analogRead() to increase by a factor of at least 100.  The timing diagram shown in figure 6 demonstrates this concept. <br>
![alt text][photo_cal]<br>
*figure 6: timing diagram for photoresistor circuit output*
##Operation
###Joel's Drum
Joel's drum serves as the reference drum for the jam band and thus is controlled in the same way discussed [here](https://github.com/jpark6694/EE-183DA-LAB-2-Electromechanical-Musical-Instrument-).
###Mark's Drum
Mark's drum is operated in a similar manner as [the original](https://github.com/mwalker55/EE183DA/tree/master/lab2), however the mark_drum.ino sketch found in this repository should be used as the website instead.  Instructions for connecting to the ESP-8266 and accessing its website can be found on the original's documentation.  The website's drop-down menu will now contain one new option: jam band sensing.  On that page, hit "Sense" to begin sensing Joel's drum and hit "Stop" to stop (or go to a different page on the drop-down menu).
###Sumedh's Drum
For Sumedh's drum, the sketch will automatically continuously sense once uploaded and thus no further action is necessary.

##Demonstration
The following video shows the jam band in operation.<br>
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/f38w0sMBbEM/0.jpg)](http://www.youtube.com/watch?v=f38w0sMBbEM)

[vib_s_diagram]: http://i.imgur.com/u5hwclw.png
[vib_s_table]: http://i.imgur.com/tSs41a3.png
[vib_s_attach]: http://i.imgur.com/RERq4f6.png
[photo_attach]: http://i.imgur.com/wd1oQgH.png
[photo_circuit]: http://i.imgur.com/O9Ccs9c.png
[photo_cal]: http://i.imgur.com/0MxYLFj.png
