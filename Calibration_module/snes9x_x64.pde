void snes() throws AWTException{
  
  for(int i=0;i<4;i++){
          
          if (count[i] > 0) {
                
                      
                      
                       if(avgY[i]<=player[i].jumpH && player[i].localizH!=CIMA){
                     
                     bot.keyPress(65+i*4);
                     println("cima"+i);
                     player[i].localizH=CIMA;
                     
                   } else  if(avgY[i]>=player[i].crouchH && player[i].localizH!=BAIXO){
                     
                     bot.keyPress(66+i*4);
                     println("baixo"+i);
                     player[i].localizH=BAIXO;
                   } else if(avgY[i]<player[i].crouchH && avgY[i]>player[i].jumpH && player[i].localizH!=CENTRO){
                     
                     bot.keyRelease(65+i*4);
                         bot.keyRelease(66+i*4);
                     player[i].localizH=CENTRO;
                     println("centroh"+i);
                     
                   } else if(avgX[i]>=player[i].leftW && player[i].localizW!=DIREITA){
                     
                     bot.keyPress(67+i*4);
                     println("esquerda"+i);
                     player[i].localizW=DIREITA;
                     
                   }else  if(avgX[i]<=player[i].rightW && player[i].localizW!=ESQUERDA){
                     
                    bot.keyPress(68+i*4);
                     println("direita"+i);
                     player[i].localizW=ESQUERDA;
                     
                   }else if(avgX[i]>player[i].rightW && avgX[i]<player[i].leftW && player[i].localizW!=CENTRO){
                     
                     bot.keyRelease(67+i*4);
                     bot.keyRelease(68+i*4);
                     player[i].localizW=CENTRO;
                     println("centrow"+i);
                     
                   }
                
                
                
            }
          
        }
  not = false;

}
