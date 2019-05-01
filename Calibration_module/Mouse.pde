void mouse() throws AWTException{
  if(!luva){
          if (count[0] > 0) {
            
            bot.mouseMove(round(map(avgX[0],player[0].rightW,player[0].leftW,d.width,0)),round(map(avgY[0],player[0].jumpH,player[0].crouchH,0,d.height)));
            
          }
          if (count[1] > 0){ 
          
                if(avgY[1]<=player[1].jumpH&& player[1].localizRH!=CIMA){
                   bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
                   
                   player[1].localizRH=CIMA;
                   drag=true;
                   
                 }
                 else if(avgY[1]>player[1].jumpH && player[1].localizRH!=CENTRO){
                   player[1].localizRH=CENTRO;
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
            bot.mouseMove(round(map(x,player[0].rightW,player[0].leftW,d.width,0)),round(map(y,player[0].jumpH,player[0].crouchH,0,d.height)));
            if(drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
               drag=false;
            }
            
            
          }else if(count[0]>0)
          {
            bot.mouseMove(round(map(avgX[0],player[0].rightW,player[0].leftW,d.width,0)),round(map(avgY[0],player[0].jumpH,player[0].crouchH,0,d.height)));
            if(!drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              drag=true;
            }
            
          }
    
  }
  
          
  not = false;
}
