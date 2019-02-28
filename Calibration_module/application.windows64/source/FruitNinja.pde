boolean drag=false;

void fruitNinja(){
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
            color currentColor = video.pixels[loc];
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
            strokeWeight(4.0);
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

void fN() throws AWTException{
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
