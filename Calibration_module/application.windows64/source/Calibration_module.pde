import processing.video.*;
import java.awt.event.*;
import java.awt.*;

  Capture video;
  Limites player;
  Robot bot;
  Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
  
  color [] trackColors; 
  float [] thresholds;
  float [] avgX;
  float [] avgY;
  int [] count;
  
  int cont;
  int screen;
  int step;
  
  
void setup() {
  size(640, 640);
  
  video = new Capture(this,640,480);
  video.start();
  
  step= 0;
  screen= 0;
  cont= 3;
  
  trackColors = new color[cont];
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

void draw() {
  
  switch(screen){
    
    case 0: 
            
        calibration();
        
    break;
    
    case 1: 
    
      subwaySurf();
    break;
  }
  
}


void mousePressed() {
  
  if(screen==0 && mouseX + mouseY*video.width<video.pixels.length){
      int loc = mouseX + mouseY*video.width;
      trackColors[step] = video.pixels[loc];
    }
  }
  
void keyPressed(){
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

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
  
}

void calibration(){
  
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
            color currentColor = video.pixels[loc];
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
            strokeWeight(4.0);
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


void captureEvent(Capture video) {
  
  video.read();
  
}
