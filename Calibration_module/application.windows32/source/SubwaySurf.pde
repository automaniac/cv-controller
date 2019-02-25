static int DIREITA= 1, ESQUERDA= -1, CENTRO=0, CIMA=1, BAIXO=-1;
boolean not = false;


void subwaySurf(){
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

void moveSubway() throws AWTException{
  
  for(int i=0;i<cont;i++){
            
          if (count[i] > 0) {// Quantidade de pixels para formar um ponto
          
            fill(trackColors[i]);
            strokeWeight(4.0);
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
