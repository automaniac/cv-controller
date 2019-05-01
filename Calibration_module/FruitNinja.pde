void fruitNinja() throws AWTException{
  if(!luva){
          if (count[0] > 0) {
            
            bot.mouseMove(round(map(avgX[0],player[0].rightW,player[0].leftW,d.width,0)),round(map(avgY[0],player[0].jumpH,player[0].crouchH,0,d.height)));
            
            if(!drag){
              bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
              drag=true;
            }
            
          }else
          {
             bot.mousePress(InputEvent.BUTTON1_DOWN_MASK);
             bot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
             drag=false;
          }
          
  }
          
  not = false;
}
