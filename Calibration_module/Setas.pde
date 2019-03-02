void setas() throws AWTException{
  
  for(int i=0;i<1;i++){
            
          if (count[i] > 0) {
            
            
               if(avgY[0]<=player.jumpH && player.localizH!=CIMA){
                 
                 bot.keyPress(38);
                 bot.keyRelease(38);
                 println("cima");
                 player.localizH=CIMA;
                 
               } else  if(avgY[0]>=player.crouchH && player.localizH!=BAIXO){
                 
                 bot.keyPress(40);
                 bot.keyRelease(40);
                 println("baixo");
                 player.localizH=BAIXO;
               } else if(avgY[0]<player.crouchH && avgY[0]>player.jumpH && player.localizH!=CENTRO){
                 
                 player.localizH=CENTRO;
                 println("centro");
                 
               } else if(avgX[0]<=player.rightW && player.localizW!=DIREITA){
                 
                 bot.keyPress(39);
                 bot.keyRelease(39);
                 println("direita");
                 player.localizW=DIREITA;
                 
               }else  if(avgX[0]>=player.leftW && player.localizW!=ESQUERDA){
                 
                bot.keyPress(37);
                 bot.keyRelease(37);
                 println("esquerda");
                 player.localizW=ESQUERDA;
                 
               }
          }
          
        }
  not = false;
}
