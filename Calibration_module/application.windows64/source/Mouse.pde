void mouse() throws AWTException{
  if(!luva){
          if (count[0] > 0) {
            
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
  } else {
    if (count[0] > 0&& count[1] > 0) {
            float x = (avgX[0]*count[0]+avgX[1]*count[1])/(count[0]+count[1]);
            float y = (avgY[0]*count[0]+avgY[1]*count[1])/(count[0]+count[1]);
            bot.mouseMove(round(map(x,player.rightW,player.leftW,d.width,0)),round(map(y,player.jumpH,player.crouchH,0,d.height)));
            if(drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
               drag=false;
            }
            
            
          }else if(count[0]>0)
          {
            bot.mouseMove(round(map(avgX[0],player.rightW,player.leftW,d.width,0)),round(map(avgY[0],player.jumpH,player.crouchH,0,d.height)));
            if(!drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              drag=true;
            }
            
          }
    
  }
  
          
  not = false;
}
