void controle(int tela){
  
  translate(0,480); // 480x160 px
  noStroke();
  fill(200);
  textSize(20);
  textAlign(LEFT,TOP);
  
  text("'←' '→' Alternar módulos ("+ screen +")",5,0);
  text("'p' Pausa ("+ (!enabled?"Ativada":"desativada") +")",5,20);
  
  if(tela==0){
    
    text("'↑' '↓' Controle ("+ step +")",5,40);
    text("' ' Cor ("+ ((cor==0)?"Primária":"Secundária") +")",5,60);
    text("'n' 'm' (-/+) Limiar ("+ thresholds[step][cor] +")",5,80);
    text("'l' Luva ("+ (luva?"Ativada":"Desativada") +")",5,100);
    text("'x' Limites ("+ (!exclusive?"Gerais":"Exclusivos") +")",5,120);
    text("'k' defLimites ("+ (limits==0?"Inferior":(limits==1?"Superior":(limits==2?"Esquerda":"Direita" ))) +")",5,140);
    textAlign(RIGHT,TOP);
    text("'mouseClick' Selecionar cor",633,0);
  }
  translate(0,-480);
  
}
