void setas() throws AWTException{
  
  for(int i=0;i<1;i++){
            
          if (count[i] > 0) {
            
            
               if(avgY[0]<=player[0].jumpH && player[0].localizH!=CIMA){
                 
                 bot.keyPress(38);
                 bot.keyRelease(38);
                 println("cima");
                 player[0].localizH=CIMA;
                 
               } else  if(avgY[0]>=player[0].crouchH && player[0].localizH!=BAIXO){
                 
                 bot.keyPress(40);
                 bot.keyRelease(40);
                 println("baixo");
                 player[0].localizH=BAIXO;
               } else if(avgY[0]<player[0].crouchH && avgY[0]>player[0].jumpH && player[0].localizH!=CENTRO){
                 
                 player[0].localizH=CENTRO;
                 println("centro");
                 
               } else if(avgX[0]>=player[0].leftW && player[0].localizW!=DIREITA){
                 
                 bot.keyPress(37);
                 bot.keyRelease(37);
                 println("esquerda");
                 player[0].localizW=DIREITA;
                 
               }else  if(avgX[0]<=player[0].rightW && player[0].localizW!=ESQUERDA){
                 
                bot.keyPress(39);
                bot.keyRelease(39);
                 println("direita");
                 player[0].localizW=ESQUERDA;
                 
               }else if(avgX[0]>player[0].rightW && avgX[0]<player[0].leftW && player[0].localizW!=CENTRO){
                 
                 player[0].localizW=CENTRO;
                 println("centro");
                 
               }
          }
          
        }
  not = false;
}
