void snes() throws AWTException{
  
  for(int i=0;i<4;i++){
          
          if (count[i] > 0) {
                if(i%2!=0){
                  
                  
                  
                   if(avgY[i]<=player[i].jumpH && player[i].localizH!=CIMA){
                 
                 bot.keyPress(65+i*4);
                 bot.keyRelease(65+i*4);
                 println("cima");
                 player[i].localizH=CIMA;
                 
               } else  if(avgY[i]>=player[i].crouchH && player[i].localizH!=BAIXO){
                 
                 bot.keyPress(66+i*4);
                 bot.keyRelease(66+i*4);
                 println("baixo");
                 player[i].localizH=BAIXO;
               } else if(avgY[i]<player[i].crouchH && avgY[i]>player[i].jumpH && player[i].localizH!=CENTRO){
                 
                 player[i].localizH=CENTRO;
                 println("centro");
                 
               } else if(avgX[i]>=player[i].leftW && player[i].localizW!=DIREITA){
                 
                 bot.keyPress(67+i*4);
                 bot.keyRelease(67+i*4);
                 println("esquerda");
                 player[i].localizW=DIREITA;
                 
               }else  if(avgX[i]<=player[i].rightW && player[i].localizW!=ESQUERDA){
                 
                bot.keyPress(68+i*4);
                bot.keyRelease(68+i*4);
                 println("direita");
                 player[i].localizW=ESQUERDA;
                 
               }else if(avgX[i]>player[i].rightW && avgX[i]<player[i].leftW && player[i].localizW!=CENTRO){
                 
                 player[i].localizW=CENTRO;
                 println("centro");
                 
               }
               
                } else {
                  
                      
                      
                       if(avgY[i]<=player[i].jumpH && player[i].localizH!=CIMA){
                     
                     bot.keyPress(65+i*4);
                     println("cima");
                     player[i].localizH=CIMA;
                     
                   } else  if(avgY[i]>=player[i].crouchH && player[i].localizH!=BAIXO){
                     
                     bot.keyPress(66+i*4);
                     println("baixo");
                     player[i].localizH=BAIXO;
                   } else if(avgY[i]<player[i].crouchH && avgY[i]>player[i].jumpH && player[i].localizH!=CENTRO){
                     
                     bot.keyRelease(65+i*4);
                         bot.keyRelease(66+i*4);
                     player[i].localizH=CENTRO;
                     println("centro");
                     
                   } else if(avgX[i]>=player[i].leftW && player[i].localizW!=DIREITA){
                     
                     bot.keyPress(67+i*4);
                     println("esquerda");
                     player[1].localizW=DIREITA;
                     
                   }else  if(avgX[i]<=player[i].rightW && player[i].localizW!=ESQUERDA){
                     
                    bot.keyPress(68+i*4);
                     println("direita");
                     player[i].localizW=ESQUERDA;
                     
                   }else if(avgX[i]>player[i].rightW && avgX[i]<player[i].leftW && player[i].localizW!=CENTRO){
                     
                     bot.keyRelease(67+i*4);
                     bot.keyRelease(68+i*4);
                     player[i].localizW=CENTRO;
                     println("centro");
                     
                   }
                
                
                }
            }
          
        }
  not = false;

}
