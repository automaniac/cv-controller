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
  
  int [][] trackColors; 
  float [][] thresholds;
  float [] avgX;
  float [] avgY;
  int [] count;
  
  int cont;
  int screen;
  int step;
  int cor;
  
  
public void setup() {
  
  
  video = new Capture(this,640,480);
  video.start();
  
  step= 0;
  cor=0;
  screen= 0;
  cont= 3;
  
  trackColors = new int[cont][2];
  thresholds = new float[cont][2];
  avgY = new float[cont];
  avgX = new float[cont];
  count= new int[cont];
  player= new Limites();
  
  try{
    
    bot= new Robot();
    
  } catch(Exception AWTException){
    
  }
  for(int i=0;i<cont;i++){
    trackColors[i][0]= color(0,0,255);
    trackColors[i][1]= color(0,0,255);
    thresholds[i][0]= 25;
    thresholds[i][1]= 25;
  }

  

  
} 

public void draw() {
  
  switch(screen){
    
    case 0: 
            
      calibration();
        
    break;
    
    case 1:
    
      ponG();
      
    break;
    
    case 2:
    
      setas();
      
    break;
    
    case 3:
    
      mouse();
      
    break;
    
    case 4:
    
      fruitNinja();
      
    case 5:
    
      subwaySurf();
      
    break;
    
  }
  
}


public void mousePressed() {
  
  if(screen==0 && mouseX + mouseY*video.width<video.pixels.length){
      int loc = mouseX + mouseY*video.width;
      trackColors[step][cor] = video.pixels[loc];
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
      case ' ':
        if(cor==0)
          cor=1;
        else
          cor=0;
      
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
      case 'n':
        thresholds[step][cor]++;
      break;
      case 'm':
        if(thresholds[step][cor]>0)
          thresholds[step][cor]--;
      break;
        
      }
    
  }
  if(key=='z'){
        screen++;
        if(screen>=6){
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
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Calibração",width/2,height/20);
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
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
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
            fill(trackColors[i][0]);
            strokeWeight(4.0f);
            stroke(trackColors[i][1]);
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
boolean drag=false;

public void fruitNinja(){
        background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Fruit Ninja",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<1;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<1;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<1;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i][0]);
            strokeWeight(4.0f);
            stroke(trackColors[i][1]);
            ellipse(avgX[i], avgY[i], 24, 24);
          }
        }
        
          
        
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
        try{
          if(!not){
             not=true; 
            thread("fN");
          }
        } catch (Exception AWTException){}
}

public void fN() throws AWTException{
          if (count[0] > 0) {// Quantidade de pixels para formar um ponto
            
            
            
            bot.mouseMove(round(map(avgX[0],player.rightW,player.leftW,d.width,0)),round(map(avgY[0],player.jumpH,player.crouchH,0,d.height)));
            
            if(!drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              drag=true;
            }
            
          }else
          {
            
             bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
             drag=false;
          }
          
  not = false;
}

public void mouse(){
        background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Jogos com mouse",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<2;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<2;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<2;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i][0]);
            strokeWeight(4.0f);
            stroke(trackColors[i][1]);
            ellipse(avgX[i], avgY[i], 24, 24);
          }
        }
        
          
        
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
        try{
          if(!not){
             not=true; 
            thread("mouseM");
          }
        } catch (Exception AWTException){}
}

public void mouseM() throws AWTException{
          if (count[0] > 0) {// Quantidade de pixels para formar um ponto
            
            
            
            bot.mouseMove(round(map(avgX[0],player.rightW,player.leftW,d.width,0)),round(map(avgY[0],player.jumpH,player.crouchH,0,d.height)));
            
            
            
          }
          if (count[1] > 0){ 
          
                if(avgY[1]<=player.jumpH&& player.localizRH!=CIMA){
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   
                   player.localizRH=CIMA;
                   drag=true;
                   
                 }
                 else if(avgY[1]>player.jumpH && player.localizRH!=CENTRO){
                   player.localizRH=CENTRO;
                   if(drag){
                     drag=false;
                     bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
                   }
                   
                 }
          
        }
          
  not = false;
}

public void ponG(){
        background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Pong",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<2;i++){
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<2;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<2;i++){
            
          if (count[i] > 0) { 
            avgY[i] = avgY[i] / count[i];
          }
        }
        
        
        
        
        fill(255);
        ellipse(Pong_x,Pong_y, Pong_diam, Pong_diam);
      
        rect(20, avgY[0]-Pong_rectSize/2 , 10, Pong_rectSize);
        rect(width-30, avgY[1]-Pong_rectSize/2, 10, Pong_rectSize);
      
        Pong_x += Pong_speedX;
        Pong_y += Pong_speedY;
      
        // if ball hits movable bar, invert X direction
        if ( Pong_x > width-30 && Pong_x < width -20 && Pong_y > avgY[1]-Pong_rectSize/2 && Pong_y < avgY[1]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        } else if ( Pong_x < 30 && Pong_x > 20 && Pong_y > avgY[0]-Pong_rectSize/2 && Pong_y < avgY[0]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        }
      
        // if ball hits wall, change direction of X
        if (Pong_x < 0||Pong_x> width) {

            Pong_x = width/2;
            Pong_y = height/2;
            Pong_speedX = random(3, 5);
            Pong_speedY = random(3, 5);
        }
      
      
        // if ball hits up or down, change direction of Y   
        if ( Pong_y > height || Pong_y < 0 ) {
          Pong_speedY *= -1;
        }
        
}

float Pong_x=width/2, Pong_y = height/2, Pong_speedX = random(3, 5), Pong_speedY = random(3, 5);
float Pong_diam = 10; 
float Pong_rectSize = 200;
public void setas(){
        background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Jogos com setas",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<1;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<1;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<1;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i][0]);
            strokeWeight(4.0f);
            stroke(trackColors[i][1]);
            ellipse(avgX[i], avgY[i], 24, 24);
          }
        }
        
          
        
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
        try{
          if(!not){
             not=true; 
            thread("goSetas");
          }
        } catch (Exception AWTException){}
}

public void goSetas() throws AWTException{
  
  for(int i=0;i<1;i++){
            
          if (count[i] > 0) {// Quantidade de pixels para formar um ponto
            
            
               if(avgY[0]<=player.jumpH && player.localizH!=CIMA){
                 
                 bot.keyPress(38);
                 bot.keyRelease(38);
                 println("cima");
                 player.localizH=CIMA;
                 
               } else  if(avgY[0]>=player.crouchH && player.localizH!=BAIXO){
                 
                 bot.keyPress(40);
                 bot.keyRelease(40);
                 println("baixo");
                 player.localizH=BAIXO;
               } else if(avgY[0]<player.crouchH && avgY[0]>player.jumpH && player.localizH!=CENTRO){
                 
                 player.localizH=CENTRO;
                 println("centro");
                 
               } else if(avgX[0]<=player.rightW && player.localizW!=DIREITA){
                 
                 bot.keyPress(39);
                 bot.keyRelease(39);
                 println("direita");
                 player.localizW=DIREITA;
                 
               }else  if(avgX[0]>=player.leftW && player.localizW!=ESQUERDA){
                 
                bot.keyPress(37);
                 bot.keyRelease(37);
                 println("esquerda");
                 player.localizW=ESQUERDA;
                 
               }
            
          }
          
        }
  
  
  not = false;
}
static int DIREITA= 1, ESQUERDA= -1, CENTRO=0, CIMA=1, BAIXO=-1;
boolean not = false;


public void subwaySurf(){
       background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Subway Surf",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<2;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            int currentColor = video.pixels[loc];
            for(int i=0;i<2;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<2;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i][0]);
            strokeWeight(4.0f);
            stroke(trackColors[i][1]);
            ellipse(avgX[i], avgY[i], 24, 24);
          }
        }
        
          
        
        line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
         line(0,player.jumpH,width,player.jumpH);
        line(0,player.crouchH,width,player.crouchH);
        line(player.leftW,0,player.leftW,height);
        line(player.rightW,0,player.rightW,height);
        try{
          if(!not){
             not=true; 
            thread("moveSubway");
          }
        } catch (Exception AWTException){}
}

public void moveSubway() throws AWTException{
  
  for(int i=0;i<2;i++){
            
          if (count[i] > 0) {// Quantidade de pixels para formar um ponto
            
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
            }
            
          }
          
        }
  
  
  not = false;
}
  public void settings() {  size(640, 480); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Calibration_module" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
