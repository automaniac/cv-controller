void ponG(){
  
        
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Pong",width/2,height/20);
        track(-2);
        
        
        fill(255);
        ellipse(Pong_x,Pong_y, Pong_diam, Pong_diam);
      
        rect(20, avgY[0]-Pong_rectSize/2 , 10, Pong_rectSize);
        rect(width-30, avgY[1]-Pong_rectSize/2, 10, Pong_rectSize);
      
        Pong_x += Pong_speedX;
        Pong_y += Pong_speedY;
      
        
        if ( Pong_x > width-30 && Pong_x < width -20 && Pong_y > avgY[1]-Pong_rectSize/2 && Pong_y < avgY[1]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        } else if ( Pong_x < 30 && Pong_x > 20 && Pong_y > avgY[0]-Pong_rectSize/2 && Pong_y < avgY[0]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        }
      
        
        if (Pong_x < 0||Pong_x> width) {

            Pong_x = width/2;
            Pong_y = height/2;
            Pong_speedX = random(3, 5);
            Pong_speedY = random(3, 5);
        }
      
      
           
        if ( Pong_y > height || Pong_y < 0 ) {
          Pong_speedY *= -1;
        }
        
}

float Pong_x=width/2, Pong_y = height/2, Pong_speedX = random(3, 5), Pong_speedY = random(3, 5);
float Pong_diam = 10; 
float Pong_rectSize = 200;
