import processing.video.*;
import java.awt.event.*;
import java.awt.*;

  Capture video;
  Limites player;
  Robot bot;
  Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
  
  color [][] trackColors; 
  float [][] thresholds;
  float [] avgX;
  float [] avgY;
  int [] count;
  
  int cont;
  int screen;
  int step;
  int cor;
  
  
void setup() {
  size(640, 480);
  
  video = new Capture(this,640,480);
  video.start();
  
  step= 0;
  cor=0;
  screen= 0;
  cont= 3;
  
  trackColors = new color[cont][2];
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

void draw() {
  
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


void mousePressed() {
  
  if(screen==0 && mouseX + mouseY*video.width<video.pixels.length){
      int loc = mouseX + mouseY*video.width;
      trackColors[step][cor] = video.pixels[loc];
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

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
  
}

void calibration(){
  
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
            color currentColor = video.pixels[loc];
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
            strokeWeight(4.0);
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


void captureEvent(Capture video) {
  
  video.read();
  
}
