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
  
  boolean luva;
  boolean drag;
  boolean not;
  static int DIREITA= 1, ESQUERDA= -1, CENTRO=0, CIMA=1, BAIXO=-1;

  
  
void setup() {
  size(640, 480);
  
  video = new Capture(this,640,480);
  video.start();
  
  luva=false;
  not= false;
  drag=false;
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
    
      normalApi(1,"Jogos com setas", "setas");
      
    break;
    
    case 3:
    
      normalApi(2,"Jogos com mouse", "mouse");
      
    break;
    
    case 4:
    
        normalApi(1,"Fruit Ninja", "fruitNinja");
        
    break;
      
    case 5:
    
      normalApi(2,"Subway Surf", "subSurf");
      
    break;
    
    case 6:
      
      normalApi(2,"Snes", "snes");
    
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
      case 'l':
        luva=!luva;
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


void calibration(){
  
        video.loadPixels();
        image(video, 0, 0);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Calibração",width/2,height/20);
        text("Luva="+luva,width/2,height/20+20);
        text("Luva="+luva,width/2,height/20+20);
        track(cont);
  
}
