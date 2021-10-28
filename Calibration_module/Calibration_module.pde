import processing.video.*;
import java.awt.event.*;
import java.awt.*;

  Capture video;
  Robot bot;
  Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
 
  Limites [] player = new Limites[4];
  color [][] trackColors; 
  float [][] thresholds;
  float [] avgX;
  float [] avgY;
  int [] count;
  
  int cont;
  int screen;
  int step;
  int cor;
  int nModulos;
  int limits;
  
  boolean luva;
  boolean drag;
  boolean not;
  boolean enabled;
  boolean exclusive;
  static int DIREITA = 1, ESQUERDA = -1, CENTRO = 0, CIMA = 1, BAIXO = -1;

  
  
void setup() {
  size(640, 640);
  
  video = new Capture(this,640,480);
  video.start();
  
  exclusive = false;
  luva = false;
  not = false;
  drag = false;
  enabled = false;
  limits=0;
  step = 0;
  cor = 0;
  screen = 0;
  cont = 4;
  nModulos = 6;
  
  trackColors = new color[cont][2];
  thresholds = new float[cont][2];
  avgY = new float[cont];
  avgX = new float[cont];
  count= new int[cont];
  for(int i=0;i<cont;i++){
    player[i]= new Limites();
  }
  
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
  
  background(40);
  controle(screen);
  
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
      normalApi(4,"Snes", "snes");
      
    break;
      
    
  }
  
}


void mousePressed() {
  
  if(screen==0 && mouseX + mouseY*video.width<video.pixels.length){
    
      int loc = mouseX + mouseY*video.width;
      trackColors[step][cor] = video.pixels[loc];
      
    }
  }
  
void setStep(){
  
}
  
void keyPressed(){
  if(screen==0){
      switch(key){
        
      
        
      
      case ' ':
      
        if(cor==0)
          cor=1;
        else
          cor=0;
          
      break;
      
      case 'k':
        switch(limits){
          
        case 0:
        
          if(exclusive)
            player[step].crouchH= avgY[step];
          else{
            for(int i=0;i<cont;i++)
              player[i].crouchH= avgY[step];
          }
        
        break;
        
        case 1:
        
          if(exclusive)
            player[step].jumpH= avgY[step];
          else{
            for(int i=0;i<cont;i++)
              player[i].jumpH= avgY[step];
          }
          
        break;
        
        case 2:
        
          if(exclusive)
            player[step].leftW= avgX[step];
          else{
            for(int i=0;i<cont;i++)
              player[i].leftW= avgX[step];
          }
        break;
        
        case 3:
          if(exclusive)
            player[step].rightW= avgX[step];
          else{
            for(int i=0;i<cont;i++)
              player[i].rightW= avgX[step];
          }
        
        break;
      }
        limits++;
        if(limits>=4)
          limits=0;
        
      break;
      
      case 'n':
      
        if(thresholds[step][cor]<300)
          thresholds[step][cor]++;
          
      break;
      
      case 'm':
        if(thresholds[step][cor]>0)
          thresholds[step][cor]--;
      break;
      
      case 'l':
        luva = !luva;
      break;
      
      case 'x':
        exclusive = !exclusive;
        
      }
      
      if(keyCode==UP){
        step++;
        if(step>=cont)
          step=0;
      } else if(keyCode==DOWN){
        step--;
        if(step<0)
          step=cont-1;
      }
      
    
  }
  
  if(keyCode==RIGHT){// Seta para a direita
    screen++;
    enabled = false;
    if(screen >= nModulos){
      screen = 0;
    }
  }
  else if(keyCode==LEFT){// Seta para a esquerda
    screen--;
    enabled = false;
    if(screen < 0){
      screen = nModulos - 1;
    }
  }
  
  else if(key=='p')// Pausar/Iniciar módulo
    enabled=!enabled;
   
  
}


void calibration(){
  
        video.loadPixels();
        image(video, 0, 0);

        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Calibração",width/2,height/20);
        track(cont);
  
}
