void fruitNinja() throws AWTException{
  if(!luva){
          if (count[0] > 0) {
            
            bot.mouseMove(round(map(avgX[0],player.rightW,player.leftW,d.width,0)),round(map(avgY[0],player.jumpH,player.crouchH,0,d.height)));
            
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
