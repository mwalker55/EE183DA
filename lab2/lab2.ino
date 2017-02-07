#include <ESP8266WiFi.h>
#include <Servo.h>

#define led_pin 16 
WiFiServer server(80);

Servo servo;

int currpage;
String beat_seq;

String home_page;
String manual_page;
String beats_page;
String songs_page;

void setup() {
  WiFi.mode(WIFI_AP);
  WiFi.softAP("mark", "12345678");
  server.begin();
  
  Serial.begin(115200);
  while(!Serial);
  Serial.println("Setup Initializing...");

  IPAddress HTTPS_ServerIP = WiFi.softAPIP();
  Serial.print("Server IP is ");
  Serial.println(HTTPS_ServerIP);
  currpage = 0;
  beat_seq = "";

  home_page = "HTTP/1.1 200 OK\r\n";
       home_page += "Content-Type: text/html\r\n\r\n";
       home_page += "<!DOCTYPE HTML>\r\n<html>\r\n";
       home_page += "<h2>Mark's Arduino Drum</h2><h3>Home Page</h3>";
       home_page += "<p>This is the home page of the control site for this Arduino drum.  Below there is a drop-down menu leading to different options for the drum.</p>";
       home_page += "<select name=\"main-menu\" onchange=\"location.href=this.options[this.selectedIndex].value;\">";
       home_page += "<option value=\"/index\" selected>Home Page</option>";
       home_page += "<option value=\"/manual\">Manual Control</option>";
       home_page += "<option value=\"/beats\">Beat Sequencer</option>";
       home_page += "<option value=\"/beats\">Pre-made Songs</option>";
       home_page += "</select></html>\n";
  manual_page = "HTTP/1.1 200 OK\r\n";
       manual_page += "Content-Type: text/html\r\n\r\n";
       manual_page += "<!DOCTYPE HTML>\r\n<html>\r\n";
       manual_page += "<h2>Mark's Arduino Drum</h2><h3>Manual Control</h3>";
       manual_page += "<p>Hit Drum to have the drum strike once.</p>";
       manual_page += "<input type=\"button\" name=\"b1\" value=\"Drum\" onclick=\"location.href='/manual/STRIKE'\"><br><br>";
       manual_page += "<select name=\"main-menu\" onchange=\"location.href=this.options[this.selectedIndex].value;\">";
       manual_page += "<option value=\"/index\">Home Page</option>";
       manual_page += "<option value=\"/manual\" selected>Manual Control</option>";
       manual_page += "<option value=\"/beats\">Beat Sequencer</option>";
       manual_page += "<option value=\"/songs\">Pre-made Songs</option>";
       manual_page += "</select></html>\n";
  songs_page = "HTTP/1.1 200 OK\r\n";
       songs_page += "Content-Type: text/html\r\n\r\n";
       songs_page += "<!DOCTYPE HTML>\r\n<html>\r\n";
       songs_page += "<h2>Mark's Arduino Drum</h2><h3>Pre-made Songs</h3>";
       songs_page += "<p>Press play below on the song you wish to listen to.</p>";
       songs_page += "<input type=\"button\" name=\"b1\" value=\"Play Song 1\" onclick=\"location.href='/songs/song1'\">&nbsp;";
       songs_page += "<input type=\"button\" name=\"b2\" value=\"Play Song 2\" onclick=\"location.href='/songs/song2'\">&nbsp;";
       songs_page += "<input type=\"button\" name=\"b3\" value=\"Play Song 3\" onclick=\"location.href='/songs/song3'\">&nbsp;";
       songs_page += "<input type=\"button\" name=\"b4\" value=\"Play Song 4\" onclick=\"location.href='/songs/song4'\">&nbsp;";
       songs_page += "<input type=\"button\" name=\"b5\" value=\"Play Song 5\" onclick=\"location.href='/songs/song5'\"><br><br>";
       songs_page += "<select name=\"main-menu\" onchange=\"location.href=this.options[this.selectedIndex].value;\">";
       songs_page += "<option value=\"/index\">Home Page</option>";
       songs_page += "<option value=\"/manual\">Manual Control</option>";
       songs_page += "<option value=\"/beats\">Beat Sequencer</option>";
       songs_page += "<option value=\"/songs\" selected>Pre-made Songs</option>";
       songs_page += "</select></html>\n";
  pinMode(led_pin, OUTPUT);
  digitalWrite(led_pin, LOW);
  Serial.println("Setup Complete.");
}

void loop() {
  WiFiClient client = server.available();
  if(!client) {
    return;
  }
  Serial.println("Somebody has connected");

  String request = client.readStringUntil('\r');
  Serial.println(request);

  String options = "";

  if(request.indexOf("/index") != -1) {
    currpage = 0;
  } else if (request.indexOf("/manual") != -1){
    if (currpage != 1) {
      currpage = 1;
    } else if (request.indexOf("/STRIKE") != -1){
      strike();
    }
  } else if (request.indexOf("/beats") != -1){
    if (currpage != 2) {
      currpage = 2;
      generateBeatsHTML("");
    } else if (request.indexOf("/remove") != -1){
      generateBeatsHTML("remove");
    } else if (request.indexOf("/clear") != -1){
      generateBeatsHTML("clear");
    } else if (request.indexOf("/add") != -1){
      Serial.println("Sending " + request.substring(request.indexOf("add"), request.indexOf("add")+4));
      generateBeatsHTML(request.substring(request.indexOf("add"), request.indexOf("add")+4));
    } else if (request.indexOf("/play") != -1){
      generateBeatsHTML("");
      playBeatSeq();
    }
  } else if (request.indexOf("/songs") != -1){
    if (currpage != 3) {
      currpage = 3;
    } else if (request.indexOf("song1") != -1){
      song1();
    } else if (request.indexOf("song2") != -1){
      song2();
    } else if (request.indexOf("song3") != -1){
      song3();
    } else if (request.indexOf("song4") != -1){
      song4();
    } else if (request.indexOf("song5") != -1){
      song5();
    }
  }

  client.flush();
  if(currpage == 0){
    client.print(home_page);
  } else if (currpage == 1){
    client.print(manual_page);
  } else if (currpage == 2){
    client.print(beats_page);
  } else if (currpage == 3){
    client.print(songs_page);
  }
  delay(1);
  Serial.println("Client disconnected");
}

void generateBeatsHTML(String option) {
  if(option.indexOf("add") != -1){
    beat_seq+=option.charAt(option.length()-1);
  } else if (option.indexOf("remove") != -1){
    if(beat_seq.length() > 0){
      beat_seq = beat_seq.substring(0, beat_seq.length()-1);
    }
  } else if (option.indexOf("clear") != -1){
    beat_seq = "";
  }

  String beatHTML = "";
  if(beat_seq==""){
    beatHTML = "(empty)";
  } else {
    for(int i = 0; i < beat_seq.length(); i++){
      beatHTML = beatHTML + "[Beat " + beat_seq.charAt(i) + "] ";
    }
  }

  beats_page = "HTTP/1.1 200 OK\r\n";
     beats_page += "Content-Type: text/html\r\n\r\n";
     beats_page += "<!DOCTYPE HTML>\r\n<html>\r\n";
     beats_page += "<h2>Mark's Arduino Drum</h2><h3>Beats Sequencer</h3>";
     beats_page += "<p>This page lets you setup a sequence of beats to be played by the drum.  There are 5 beats you can sequence together.</p>";
     beats_page += "<p>Current beat sequence is: " + beatHTML + "</p>";
     beats_page += "<input type=\"button\" name=\"b1\" value=\"Add Beat 1\" onclick=\"location.href='/beats/add1'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b2\" value=\"Add Beat 2\" onclick=\"location.href='/beats/add2'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b3\" value=\"Add Beat 3\" onclick=\"location.href='/beats/add3'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b4\" value=\"Add Beat 4\" onclick=\"location.href='/beats/add4'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b5\" value=\"Add Beat 5\" onclick=\"location.href='/beats/add5'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b6\" value=\"Remove Last\" onclick=\"location.href='/beats/remove'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b7\" value=\"Clear All\" onclick=\"location.href='/beats/clear'\">&nbsp;";
     beats_page += "<input type=\"button\" name=\"b8\" value=\"Play\" onclick=\"location.href='/beats/play'\"><br><br>";
     beats_page += "<select name=\"main-menu\" onchange=\"location.href=this.options[this.selectedIndex].value;\">";
     beats_page += "<option value=\"/index\">Home Page</option>";
     beats_page += "<option value=\"/manual\">Manual Control</option>";
     beats_page += "<option value=\"/beats\" selected>Beat Sequencer</option>";
     beats_page += "<option value=\"/songs\">Pre-made Songs</option>";
     beats_page += "</select></html>\n"; 
}

void playBeatSeq(){
  for(int i = 0; i < beat_seq.length(); i++){
    char c = beat_seq.charAt(i);
    if(c == '1'){
      beat1();
    } else if (c == '2') {
      beat2();
    } else if (c == '3') {
      beat3();
    } else if (c == '4') {
      beat4();
    } else if (c == '5') {
      beat5();
    }
    delay(5);
  }
}

void strike() {
  servo.attach(D6);
  servo.write(30);
  delay(90);
  servo.write(80);
  delay(90);
  servo.detach();
}

void beat1() {
  strike();
  delay(50);
  strike();
  delay(50);
  strike();
  delay(50);
}

void beat2() {
  strike();
  delay(500);
  strike();
  delay(500);
  strike();
  delay(500);
}

void beat3() {
  strike();
  delay(250);
  strike();
  delay(15);
  strike();
  delay(15);
}

void beat4() {
  strike();
  delay(50);
  strike();
  delay(50);
  strike();
  delay(75);
  strike();
  delay(100);
}

void beat5() {
  for(int i = 0; i < 5; i++){
    strike();
  }
}

void song1() {
  beat1();
  beat2();
  beat1(); 
  beat1();
  beat4();
  beat2();
  beat5();
}

void song2() {
  beat5(); 
  beat4();
  beat3();
  for(int i = 0; i < 5; i++){
    beat5();
    beat2();
  }
  beat1();
}

void song3() {
  beat3();
  beat4();
  beat5();
  beat3();
  beat1();
  beat1();
  beat4();
  beat2();
}

void song4() {
  beat2(); beat1(); beat2();
  beat3(); beat2(); beat3();
  beat4(); beat3(); beat4();
  beat5(); beat4(); beat5();
}

void song5() {
  for(int i = 0; i < 10; i++){
    beat1(); beat2(); beat5();
  }
}
