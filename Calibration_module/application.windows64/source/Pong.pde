
void ponG(){
        background(50);
        fill(255);
        textAlign(CENTER);  
        textSize(20);
        text("Pong",width/2,height/20);
        video.loadPixels();
        for(int i=0;i<2;i++){
          avgY[i]=0;
          count[i]=0;
        }
      
        for (int x = 0; x < video.width; x++ ) {
          for (int y = 0; y < video.height; y++ ) {
            int loc = x + y * video.width;
            // What is current color
            color currentColor = video.pixels[loc];
            for(int i=0;i<2;i++){
              float d = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][0]), green(trackColors[i][0]), blue(trackColors[i][0])); 
              float d1 = distSq(red(currentColor), green(currentColor), blue(currentColor), red(trackColors[i][1]), green(trackColors[i][1]), blue(trackColors[i][1])); 
              if (d < thresholds[i][0]*thresholds[i][0]||d1 < thresholds[i][1]*thresholds[i][1]) {
                avgX[i] += x;
                avgY[i] += y;
                count[i]++;
              }
            }
          }
        }
      
        for(int i=0;i<2;i++){
            
          if (count[i] > 0) { 
            avgY[i] = avgY[i] / count[i];
          }
        }
        
        
        
        
        fill(255);
        ellipse(Pong_x,Pong_y, Pong_diam, Pong_diam);
      
        rect(20, avgY[0]-Pong_rectSize/2 , 10, Pong_rectSize);
        rect(width-30, avgY[1]-Pong_rectSize/2, 10, Pong_rectSize);
      
        Pong_x += Pong_speedX;
        Pong_y += Pong_speedY;
      
        // if ball hits movable bar, invert X direction
        if ( Pong_x > width-30 && Pong_x < width -20 && Pong_y > avgY[1]-Pong_rectSize/2 && Pong_y < avgY[1]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        } else if ( Pong_x < 30 && Pong_x > 20 && Pong_y > avgY[0]-Pong_rectSize/2 && Pong_y < avgY[0]+Pong_rectSize/2 ) {
          Pong_speedX = Pong_speedX * -1;
        }
      
        // if ball hits wall, change direction of X
        if (Pong_x < 0||Pong_x> width) {

            Pong_x = width/2;
            Pong_y = height/2;
            Pong_speedX = random(3, 5);
            Pong_speedY = random(3, 5);
        }
      
      
        // if ball hits up or down, change direction of Y   
        if ( Pong_y > height || Pong_y < 0 ) {
          Pong_speedY *= -1;
        }
        
}

float Pong_x=width/2, Pong_y = height/2, Pong_speedX = random(3, 5), Pong_speedY = random(3, 5);
float Pong_diam = 10; 
float Pong_rectSize = 200;
