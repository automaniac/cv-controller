void snes() throws AWTException{
  
  for(int i=0;i<2;i++){
            
          if (count[i] > 0) {
            
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
