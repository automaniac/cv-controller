import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 
import java.awt.event.*; 
import java.awt.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Calibration_module extends PApplet {





  Capture video;
  Limites player;
  Robot bot;
  Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
  
  int [] trackColors; 
  float [] thresholds;
  float [] avgX;
  float [] avgY;
  int [] count;
  
  int cont;
  int screen;
  int step;
  
  
public void setup() {
  
  
  video = new Capture(this,640,480);
  video.start();
  
  step= 0;
  screen= 0;
  cont= 3;
  
  trackColors = new int[cont];
  thresholds = new float[cont];
  avgY = new float[cont];
  avgX = new float[cont];
  count= new int[cont];
  player= new Limites();
  
  try{
    
    bot= new Robot();
    
  } catch(Exception AWTException){
    
  }
  for(int i=0;i<cont;i++){
    trackColors[i]= color(0,0,255);
    thresholds[i]= 25;
  }

  

  
} 

public void draw() {
  
  switch(screen){
    
    case 0: 
            
        calibration();
        
    break;
    
    case 1: 
    
      subwaySurf();
    break;
  }
  
}


public void mousePressed() {
  
  if(screen==0 && mouseX + mouseY*video.width<video.pixels.length){
      int loc = mouseX + mouseY*video.width;
      trackColors[step] = video.pixels[loc];
    }
  }
  
public void keyPressed(){
  if(screen==0){
      switch(key){
      case '0':
        step= Integer.parseInt(key+"");
      break;
      case '1':
        step= Integer.parseInt(key+"");
      break;
      case '2':
        step= Integer.parseInt(key+"");
      break;
      case '3':
        step= Integer.parseInt(key+"");
      break;
      case '4':
        step= Integer.parseInt(key+"");
      break;
      case '5':
        step= Integer.parseInt(key+"");
      break;
      case '6':
        step= Integer.parseInt(key+"");
      break;
      case '7':
        step= Integer.parseInt(key+"");
      break;
      case '8':
        step= Integer.parseInt(key+"");
      break;
      case '9':
        step= Integer.parseInt(key+"");
      break;
     
      
      case 'w':
        player.normalH= avgY[0];
        println("normal");
      break;
      case 'q':
        player.crouchH= (2*avgY[0]+player.normalH)/3;
        println("agachamento");
      break;
      case 'e':
        player.jumpH= (2*avgY[0]+player.normalH)/3;
        println("pulo");
      break;
      case 's':
        player.centerW = avgX[0];
        println("centro");
      break;
      case 'a':
        player.leftW= (2*avgX[0]+player.centerW)/3;
        println("esquerda");
      break;
      case 'd':
        player.rightW= (2*avgX[0]+player.centerW)/3;
        println("direita");
      break;
      }
    
  }
  if(key=='z'){
        screen++;
        if(screen>=2){
          screen=0;
        }
  }
}

class Limites{
  float normalH=0, jumpH=0, crouchH=0, centerW=0,leftW=0,rightW=0;
  
  int localizH=CENTRO,localizW=CENTRO, localizRH=CENTRO, localizLH=CENTRO;
  
}

public float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
  
}

public void calibration(){
  
        video.loadPixels();
        image(video, 0, 0);
        for(int i=0;i<cont;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
          
        }
        
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<cont;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i]), green(trackColors[i]), blue(trackColors[i])); 
              
              if (d < thresholds[i]*thresholds[i]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
        
        for(int i=0;i<cont;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i]);
            strokeWeight(4.0f);
            stroke(255);
            ellipse(avgX[i], avgY[i], 24, 24);
          }
        }
        noFill();
        stroke(255,0,255);
        strokeWeight(2);
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
  
  
}


public void captureEvent(Capture video) {
  
  video.read();
  
}

static int DIREITA= 1, ESQUERDA= -1, CENTRO=0, CIMA=1, BAIXO=-1;
boolean not = false;


public void subwaySurf(){
        background(0);
        video.loadPixels();
        for(int i=0;i<cont;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<cont;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i]), green(trackColors[i]), blue(trackColors[i])); 
              
              if (d < thresholds[i]*thresholds[i]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
              
            }
          }
        }
      
        for(int i=0;i<cont;i++){
            
          if (count[i] > 0) { 
            
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i]);
            strokeWeight(4.0f);
            stroke(255);
            ellipse(avgX[i], avgY[i], 24, 24);
            
          }
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
          
        }
        try{
          if(!not){
             not=true; 
            thread("moveSubway");
          }
        } catch (Exception AWTException){}
}

public void moveSubway() throws AWTException{
  
  for(int i=0;i<cont;i++){
            
          if (count[i] > 0) {// Quantidade de pixels para formar um ponto
          
            fill(trackColors[i]);
            strokeWeight(4.0f);
            stroke(255);
            ellipse(avgX[i], avgY[i], 24, 24);
            
            switch(i){
              case 0:
               if(avgY[0]<=player.jumpH && player.localizH!=CIMA){
                 bot.mouseMove(d.width/2,d.height/2);
                 bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                 bot.delay(30);
                 bot.mouseMove(d.width/2,d.height/2 -20);
                 bot.delay(30);
                 bot.mouseMove(d.width/2,d.height/2 -40);
                 bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                 println("pulo");
                 player.localizH=CIMA;
                 
               }else  if(avgY[0]>=player.crouchH && player.localizH!=BAIXO){
                 bot.mouseMove(d.width/2,d.height/2);
                 bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                 bot.delay(30);
                 bot.mouseMove(d.width/2,d.height/2 +20);
                 bot.delay(30);
                 bot.mouseMove(d.width/2,d.height/2 +40);
                 bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                 println("agachamento");
                 player.localizH=BAIXO;
               }
               else if(avgY[0]<player.crouchH && avgY[0]>player.jumpH && player.localizH!=CENTRO){
                 player.localizH=CENTRO;
                 println("centro");
                 
               }
               
               
               
               else if(avgX[0]<=player.rightW && player.localizW!=DIREITA){
                 
                 
                 bot.mouseMove(d.width/2,d.height/2);
                 bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                 bot.delay(30);
                 bot.mouseMove(d.width/2+20,d.height/2);
                 bot.delay(30);
                 bot.mouseMove(d.width/2+40,d.height/2);
                 bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                 println("direita");
                 player.localizW=DIREITA;
                 
               }else  if(avgX[0]>=player.leftW && player.localizW!=ESQUERDA){
                 bot.mouseMove(d.width/2,d.height/2);
                 bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                 bot.delay(30);
                 bot.mouseMove(d.width/2-20,d.height/2);
                 bot.delay(30);
                 bot.mouseMove(d.width/2-40,d.height/2);
                 bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                 println("esquerda");
                 player.localizW=ESQUERDA;
               }
               else if(avgX[0]<player.leftW && avgX[0]>player.rightW && player.localizW!=CENTRO){
                 if(player.localizW==ESQUERDA){
                   bot.mouseMove(d.width/2,d.height/2);
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   bot.delay(30);
                   bot.mouseMove(d.width/2+20,d.height/2);
                   bot.delay(30);
                   bot.mouseMove(d.width/2+40,d.height/2);
                   bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                   
                 }else{
                   bot.mouseMove(d.width/2,d.height/2);
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   bot.delay(30);
                   bot.mouseMove(d.width/2-20,d.height/2);
                   bot.delay(30);
                   bot.mouseMove(d.width/2-40,d.height/2);
                   bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                 }
                 println("Ccentro");
                 player.localizW=CENTRO;
                 
               }
               
               
               
              break;
                
              case 1:
                if(avgY[1]<=avgY[0]&& player.localizRH!=CIMA){
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                   bot.delay(20);
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                   println("skate");
                   player.localizRH=CIMA;
                   
                 }
                 else if(avgY[1]>avgY[0]&&player.localizRH!=CENTRO){
                   player.localizRH=CENTRO;
                   
                 }
                
              break;
              
              case 2:
                bot.mouseMove(round(map(avgX[2],0,width,d.width,0)),round(map(avgY[2],0,height,0,d.height)));
              break;
            }
            
          }
          
        }
  
  
  not = false;
}
  public void settings() {  size(640, 640); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Calibration_module" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
