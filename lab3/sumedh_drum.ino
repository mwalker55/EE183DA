#include <Servo.h>
#include <ESP8266WiFi.h>
#define led_pin 13
WiFiServer server(80);
Servo arm;
Servo drumstick;

// Relevant information to help move the motors appropriately
int positions = 3; //Number of drums.
int period = 300;
int current;
int delays = 60;
int val1, val2;

void setup()
{
  WiFi.mode(WIFI_AP); //Our ESP8266-12E is an AccessPoint
  WiFi.softAP("Lan Ho", "helloworld"); // Provide the (SSID, password)
  server.begin();
  arm.attach(D4);
  drumstick.attach(D3);
  current = 0; 
  arm.writeMicroseconds(1400);
  int val1 = 0;
  int val2 = 1023;
  pinMode(A0, INPUT);
}
void tune(int target)
{
  arm.writeMicroseconds(1400);
  int diff = target - current;
  
  if(diff >= 0)
  {
    arm.write(30 + 30/(positions+2)*diff);
    delay(period + delays*diff*sqrt(diff));
    arm.writeMicroseconds(1400);
  }
  else
  {
    arm.write(0);
    arm.write(25 + 25/(positions)*diff);
    delay(period + delays*(-diff)*sqrt(-diff));
    arm.writeMicroseconds(1400);
  } 
   
   //drumstick.write(45);
   //delay(100);
   drumstick.write(0);
   arm.writeMicroseconds(1400);
   delay(100);
   drumstick.write(45);
   arm.writeMicroseconds(1400);
   delay(100);
   current = target;
   arm.writeMicroseconds(1400);
}

void sense()
{
  val1 = analogRead(A0);
  delay(1);
  
  if (val1-val2 > 100)
    {
      Serial.println(val1);
      tune(1); 
    } 
  else 
    {
      Serial.println("No change");
    }
    
  val2 = val1;
  delay(100);
}

void loop()
{
  WiFiClient client = server.available();
  if (!client) 
  { 
   sense();
   return;
  }

  String request = client.readStringUntil('r');
  if (request.indexOf("/tune1") != -1)
   {
     tune(1); 
   }
   else if (request.indexOf("/tune2") != -1)
   {
     tune(2); 
   }
   else if (request.indexOf("/tune3") != -1)
   {
     tune(3); 
   }
   else if (request.indexOf("/sense") != -1)
   {
     sense(); 
   }

  String s = "HTTP/1.1 200 OK\r\n";
   s += "Content-Type: text/html\r\n\r\n";
   s += "<!DOCTYPE HTML>\r\n<html>\r\n";
   
   s += "<br><input type=\"button\" name=\"b1\" value=\"tune1\" onclick=\"location.href='/tune1'\">";
   s += "<br><input type=\"button\" name=\"b1\" value=\"tune2\" onclick=\"location.href='/tune2'\">";
   s += "<br><input type=\"button\" name=\"b1\" value=\"tune3\" onclick=\"location.href='/tune3'\">";
   s += "<br><br><br>";
   s += "<br><input type=\"button\" name=\"b1\" value=\"sense\" onclick=\"location.href='/sense'\">";
   s += "</html>\n";
   //Serve the HTML document to the browser.
    pinMode(led_pin, OUTPUT);
  digitalWrite(led_pin, LOW);
   client.flush(); //clear previous info in the stream
   client.print(s); // Send the response to the client
   delay(1);
}
