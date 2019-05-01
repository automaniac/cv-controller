void normalApi(int marcadores, String name, String nameF){
  background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text(name,width/2,height/20);
        track(marcadores);
        try{
          if(!not){
             not=true; 
            thread(nameF);
          }
        } catch (Exception AWTException){}
}

void track(int contt){
  boolean har=false;
  if(contt<0){
    har=true;
    contt*=-1;
  }
  video.loadPixels();
  for(int i=0;i<contt;i++){
          avgX[i]=0;
          avgY[i]=0;
          count[i]=0;
          
        }
        
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            color currentColor = video.pixels[loc];
            for(int i=0;i<contt;i++){
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
        
        for(int i=0;i<contt;i++){
            
          if (count[i] > 0) { 
            avgX[i] = avgX[i] / count[i];
            avgY[i] = avgY[i] / count[i];
            // Draw a circle at the tracked pixel
            fill(trackColors[i][0]);
            if(!har){
              strokeWeight(4.0);
              stroke(trackColors[i][1]);
              ellipse(avgX[i], avgY[i], 24, 24);
            }
          }
        }
        if(!har){
          noFill();
          stroke(255,0,255);
          strokeWeight(2);
          line(0,player.jumpH,width,player.jumpH);
          line(0,player.crouchH,width,player.crouchH);
          line(player.leftW,0,player.leftW,height);
          line(player.rightW,0,player.rightW,height);
        }
}

void captureEvent(Capture video) {
  
  video.read();
  
}

class Limites{
  float normalH=0, jumpH=0, crouchH=0, centerW=0,leftW=0,rightW=0;
  
  int localizH=CENTRO,localizW=CENTRO, localizRH=CENTRO, localizLH=CENTRO;
  
}

float distSq(float x1, float y1, float z1, float x2, float y2, float z2) {
  
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) +(z2-z1)*(z2-z1);
  return d;
  
}
