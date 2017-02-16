#Team Velma's ESP-8266 Instrument Jam Band
##Introduction
This jam band powered by the ESP-8266 constitutes Team Velma's submission for lab 3 of EE183DA Winter 2017.
##Construction
First, construct the three constiuent instruments:<br>
1. [Mark's Arduino Drum](https://github.com/mwalker55/EE183DA/tree/master/lab2)<br>
2. [Joel's Drum](placeholderlink)<br>
3. [Sumedh's Drum](placeholderlink)<br>
##Theory of Operation
###Vibration Sensor
The vibration sensor attached to Joel's drum's arm serves as a variable resistor in a voltage divider circuit as shown in the circuit diagram in figure X.<br>
![alt text][vib_s_diagram]<br>
*figure X: circuit diagram for vibration sensor*<br>
When Joel's drum is stationary, the resistance in the vibration sensor is small and thus the analog output value is high.  When Joel's drum is in motion, the resistance in the vibration sensor increases and thus the analog output value drops.  These changes were calibrated for control purposes and are shown in table in figure Y.<br>
![alt text][vib_s_table]<br>
*figure Y: calibration table for vibration sensor*<br>
When the analogRead() value is detected to have dropped significantly, Joel's drum is in motion and thus Mark's drum activates itself for one beat.<br>



[vib_s_diagram]: http://i.imgur.com/I4mfmw4.png
[vib_s_table]: http://i.imgur.com/O1WhZPy.png
