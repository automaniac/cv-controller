static int DIREITA= 1, ESQUERDA= -1, CENTRO=0, CIMA=1, BAIXO=-1;
boolean not = false;


void subwaySurf(){
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
            color currentColor = video.pixels[loc];
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
            strokeWeight(4.0);
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

void moveSubway() throws AWTException{
  
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
