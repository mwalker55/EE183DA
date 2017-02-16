#Team Velma's ESP-8266 Instrument Jam Band
##Introduction
This jam band powered by the ESP-8266 constitutes Team Velma's submission for lab 3 of EE183DA Winter 2017.
##Construction
First, construct the three constiuent instruments:<br>
1. [Mark's Arduino Drum](https://github.com/mwalker55/EE183DA/tree/master/lab2)<br>
2. [Joel's Drum](https://github.com/jpark6694/EE-183DA-LAB-2-Electromechanical-Musical-Instrument-)<br>
3. [Sumedh's Drum](https://github.com/sumedhvijay/Drum)<br>
Joel's drum will act as the reference drum for the jam band.  For sensing it for Mark's drum, attach the vibration sensor to the bottom of the drum stick as shown in figure N.<br>
![alt text][vib_s_attach]<br>
*figure N: vibration sensor taped onto arm of Joel's drum*<br>
Attach this vibration sensor into the circuit diagram shown in figure X, using the 5V source, A0 and GND from Mark's drum's ESP8266.  In implementing the diagram, use the vibration sensor as the switch.<br>
![alt text][vib_s_diagram]<br>
*figure X: circuit diagram for vibration sensor*<br>
On the base that Joel's drum strikes against, attach a LED on one side of the point that the drum strikes and attach a photoresistor on the other end as shown in figure R.<br>
![alt text][photo_attach]<br>
*figure R: LED and photoresistor opposite from one another at strike point*<br>
Attach the LED and photoresistor into the following two circuits shown in figure A, using the 5V source on Sumedh's drum's ESP8266 as Vcc and setting VOUT2 to be A0 on Sumedh's drum's ESP8266.<br>
![alt text][photo_circuit]<br>
*figure A: circuit diagrams for LED and photoresistor*<br>
For the Arduino sketches, Joel's remains unchanged from the sketch found in the link above.  For Mark's drum, use the mark_drum.ino sketch found in this repo and for Sumedh's drum use the sumedh_drum.ino sketch found in this repo.
##Theory of Operation
###Vibration Sensor
The vibration sensor attached to Joel's drum's arm serves as a switch as shown in the circuit diagram in figure X above.  When Joel's drum is stationary, the vibration sensor serves as an open switch and thus the analog output value is high.  When Joel's drum is in motion, the vibration sensor serves as a closed switch and thus the analog output value drops.  These changes were calibrated for control purposes and are shown in table in figure Y.<br>
![alt text][vib_s_table]<br>
*figure Y: calibration table for vibration sensor*<br>
When the analogRead() value is detected to have dropped significantly, Joel's drum is in motion and thus Mark's drum activates itself for one beat.<br>
###Photoresistor
When the drum passes between the LED and photoresistor, the photoresistor's resistance drops, meaning a larger portion of the voltage drop in the divider circuit is across the 10K resistor.  Thus, the analogRead() output increases. Calibrated values are shown in the table in figure A.<br>
##Operation
###Joel's Drum
Joel's drum serves as the reference drum for the jam band and thus is controlled in the same way discussed [here](https://github.com/jpark6694/EE-183DA-LAB-2-Electromechanical-Musical-Instrument-).
###Mark's Drum
Mark's drum is operated in a similar manner as [the original](https://github.com/mwalker55/EE183DA/tree/master/lab2), however the mark_drum.ino sketch found in this repository should be used as the website instead.  Instructions for connecting to the ESP-8266 and accessing its website can be found on the original's documentation.  The website's drop-down menu will now contain one new option: jam band sensing.  On that page, hit "Sense" to begin sensing Joel's drum and hit "Stop" to stop (or go to a different page on the drop-down menu).
###Sumedh's Drum


##Demonstration
The following video shows the jam band in operation.<br>
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/40Gdmw4ancg/0.jpg)](http://www.youtube.com/watch?v=40Gdmw4ancg)

[vib_s_diagram]: http://i.imgur.com/u5hwclw.png
[vib_s_table]: http://i.imgur.com/tSs41a3.png
[vib_s_attach]: http://i.imgur.com/RERq4f6.png
[photo_attach]: http://i.imgur.com/wd1oQgH.png
[photo_circuit]: http://i.imgur.com/O9Ccs9c.png
