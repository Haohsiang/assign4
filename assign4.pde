//You should implement your assign3 here.
PImage bg1, bg2, treasure, enemy, fighter, hp, start1, start2, end1, end2;
float hpX, treasureX, treasureY, bgFirstX, bgSecondX, fighterX, fighterY;
final int GAME_START = 1, GAME_RUN = 2, GAME_LOSE = 3;
int gameState;
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;
float fighterSpeed = 5;
float [] enemyFirstX = new float [5];
float [] enemyFirstY = new float [5];
float [] enemySecondX = new float [5];
float [] enemySecondY = new float [5];
float [] enemyThirdX = new float [8]; 
float [] enemyThirdY = new float [8];
float enemySpeed = 2;
float enemyDetectorFirst, enemyDetectorSecond, enemyDetectorThird;
PImage[] flame= new PImage [5];
int numFrame=5;
int currentFrame;



void setup () {
  size(640,480) ;  
  
  //start
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  gameState = GAME_START;
  
  //end
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  
  //background
  bg1 = loadImage("img/bg1.png");  
  bg2 = loadImage("img/bg2.png");
  bgFirstX = 0;
  bgSecondX = -641;
  
  //treasure
  treasure = loadImage("img/treasure.png");
  treasureX = random(600); // let the picture inside the screen
  treasureY = random(440); // let the picture inside the screen
  
  //enemy 
  enemy = loadImage("img/enemy.png");
    //X, first & second 
  for(int i=0; i<5; i++){      //assign x coordinate in first enemy
    enemyFirstX[i] = 0-i*61;
    enemySecondX[i] = (0-640-61*5)-i*61;
  }

    //X, third
  for(int i=0; i<8; i++){
     if (0<=i && i<=4){
      enemyThirdX[i] = (0-640-61*5)*2-i*61;
    }else if(5<=i && i<=7){
      enemyThirdX[i] = (0-640-61*5)*2-(i-4)*61;
    }
  }
  
  //enemyDetecor, always follow the last X coordinate
  enemyDetectorFirst = enemyFirstX[4];
 // println("enemyDetectorFirst="+enemyDetectorFirst);
  enemyDetectorSecond = enemySecondX[4];
 //   println("enemyDetectorSecond="+enemyDetectorSecond);
  enemyDetectorThird = enemyThirdX[4];
 //   println("enemyDetectorThird="+enemyDetectorThird);
 
  //Y[0]
    enemyFirstY[0] = random(420);
    enemySecondY[0] = random(175); //480-61*5=175
    enemyThirdY[0] = random(122,297); //61*2=128; 480-61*3=297 
  //Y, first & second
  for(int i=1; i<5; i++){
    enemyFirstY[i] = enemyFirstY[0];
    enemySecondY[i] = enemySecondY[0]+i*61;
  }
  //Y, third
  enemyThirdY[1]= enemyThirdY[0]-61*1;
  enemyThirdY[2]= enemyThirdY[0]-61*2;
  enemyThirdY[3]= enemyThirdY[0]-61*1;
  enemyThirdY[4]= enemyThirdY[0];
  enemyThirdY[5]= enemyThirdY[0]+61*1;
  enemyThirdY[6]= enemyThirdY[0]+61*2;
  enemyThirdY[7]= enemyThirdY[0]+61*1;
  
  //fighter
  fighter = loadImage("img/fighter.png");
  fighterX = 589;
  fighterY = 214.5;
 
  //hp (top)
  fill(#CC0000);
  hpX = (205-10)*20/100; //10<=hpX<=205, at least 20 points of blood 
  hp = loadImage("img/hp.png"); 
  
  //flame
   for(int i=0; i<5; i++){
    flame[i]= loadImage("img/flame"+(i+1)+".png");
  }
  currentFrame=0;
  frameRate(60);
 
}

void draw() {
switch (gameState){
    case GAME_START:
      image(start2, 0, 0);
      //mouse detecting
      if (mouseX >= width*95/300 && mouseX <= width*215/300 &&
          mouseY >= height*390/500 && mouseY <= height*435/500){
          image(start1, 0, 0);
      }else{
        image (start2, 0, 0);
      }
      //click to start
      if (mousePressed){
        if (mouseX >= width*95/300 && mouseX <= width*215/300 && 
            mouseY >= height*390/500 && mouseY <= height*435/500){
            gameState = GAME_RUN;
          }
      }
      break;
      
    case GAME_RUN:
     
      //background
      image(bg1, bgFirstX, 0);
      image(bg2, bgSecondX, 0);
      bgFirstX++;
      bgSecondX++;
      
      if (bgFirstX >= 641){
        bgFirstX = -641;
      }
      if (bgSecondX >= 641){
        bgSecondX = -641;
      } 
       
      //treasure
      image(treasure, treasureX, treasureY);
      
      //enemy
      //first team
      enemyDetectorFirst += enemySpeed; 
     if(enemyDetectorFirst>=640){    //tell relation of Y
        enemyFirstY[0] = random(420);
        enemyFirstY[1]=enemyFirstY[0];
        enemyFirstY[2]=enemyFirstY[0];
        enemyFirstY[3]=enemyFirstY[0];
        enemyFirstY[4]=enemyFirstY[0];
   //     println("doneResetEnemyFirstY="+enemyFirstY[0]);
       } 

     for(int i=0; i<5; i++){
       image(enemy, enemyFirstX[i], enemyFirstY[i]); //show the image
       enemyFirstX[i] += enemySpeed;   
       if(enemyFirstX[i]>=640){   // X go back
          enemyFirstX[i]=0-640*2-61*5*3; 
       }   
       if(enemyDetectorFirst >=640){   //detetor to reset Y
         enemyDetectorFirst = 0-640*2-61*5*3;
       }
     } 
         
      //second team 
     enemyDetectorSecond += enemySpeed;  
     if(enemyDetectorSecond>=640){     //tell relation of Y
        enemySecondY[0] = random(175);
        enemySecondY[1]=enemySecondY[0]+61;
        enemySecondY[2]=enemySecondY[0]+61*2;
        enemySecondY[3]=enemySecondY[0]+61*3;
        enemySecondY[4]=enemySecondY[0]+61*4;
     //   println("doneResetEnemySecondY="+enemySecondY[0]);
       }   
          
     for(int i=0; i<5; i++){
       image(enemy, enemySecondX[i], enemySecondY[i]); //show the image     
       enemySecondX[i] += enemySpeed; 
       if(enemySecondX[i]>=640){
         enemySecondX[i]=0-640*2-61*5*3; //X move back
       }
       if( enemyDetectorSecond >= 640){  //detetor to reset Y
        enemyDetectorSecond = 0-640*2-61*5*3;
       }
     }

     
     //third team
     enemyDetectorThird += enemySpeed;
     if(enemyDetectorThird>=640){ //tell relation of Y
       enemyThirdY[0] = random(122, 297);
       enemyThirdY[1]= enemyThirdY[0]-61*1;
       enemyThirdY[2]= enemyThirdY[0]-61*2;
       enemyThirdY[3]= enemyThirdY[0]-61*1;
       enemyThirdY[4]= enemyThirdY[0];
       enemyThirdY[5]= enemyThirdY[0]+61*1;
       enemyThirdY[6]= enemyThirdY[0]+61*2;
       enemyThirdY[7]= enemyThirdY[0]+61*1; 
    //   println("doneResetEnemyThirdY="+enemyThirdY[0]);
     } 
              
     for(int i=0; i<8; i++){
       image(enemy, enemyThirdX[i], enemyThirdY[i]);
       enemyThirdX[i] += enemySpeed;
       if(enemyThirdX[i]>=640){   
         enemyThirdX[i] = 0-640*2-61*5*3; //X move back
       }
       if(enemyDetectorThird >= 640){  //detetor to reset Y
         enemyDetectorThird = 0-640*2-61*5*3;
       }
     }  
    
      //fighter
      image(fighter, fighterX, fighterY); // the rightest, in the middle
        //derection controlling
      if (upPressed){
        fighterY -= fighterSpeed; 
      }
      if (downPressed){
        fighterY += fighterSpeed;
      }
      if (leftPressed){
        fighterX -= fighterSpeed;
      }
      if (rightPressed){
        fighterX += fighterSpeed;
      }
        //boundary controlling
      if (fighterX>589){
        fighterX = 589;
      }
      if (fighterX<0){
        fighterX = 0;
      }
      if (fighterY>429){
        fighterY = 429;
      }
      if (fighterY<0){
        fighterY = 0;
      }
      
      //hp
      fill(#CC0000);
      rectMode(CORNERS);
      rect(10,4.2,hpX,24); //under
      image(hp, 0, 0); //above
     
      //when enemy touches fighter
      
         //First
       for(int i=0; i<5 ; i++){ 
         if ( abs((fighterX+51.0/2)-(enemyFirstX[i]+61.0/2)) <= 56 && 
              abs((fighterY+51.0/2)-(enemyFirstY[i]+61.0/2)) <= 56){
              hpX = hpX - (205-10)*20/100; 
              enemyFirstX[i] = (0-640*2-61*5*3) - (640-enemyFirstX[i]); // disappear, go back earlier, but match the team
         }
         
         //Second
         if ( abs((fighterX+51.0/2)-(enemySecondX[i]+61.0/2)) <= 56 && 
              abs((fighterY+51.0/2)-(enemySecondY[i]+61.0/2)) <= 56){
              hpX = hpX - (205-10)*20/100;
              enemySecondX[i] = (0-640*2-61*5*3) - (640-enemySecondX[i]); // disapper, go back earlier, but match the team
         }
       }
       
       //Third
       for(int i=0; i<8 ; i++){
         if ( abs((fighterX+51.0/2)-(enemyThirdX[i]+61.0/2)) <= 56 && 
              abs((fighterY+51.0/2)-(enemyThirdY[i]+61.0/2)) <= 56){
              hpX = hpX - (205-10)*20/100;
              enemyThirdX[i] = (0-640*2-61*5*3) - (640-enemyThirdX[i]); // disappear, go back earlier, but match the team
         }
       }   
      
     //when fighter touches treasure, including eight situations
     
     if (treasureX < fighterX && treasureY < fighterY && treasureX + 41 > fighterX && treasureY > fighterY){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;} // add blood 10%
       treasureX = random(600); 
       treasureY = random(440);
     }
     if (treasureX < fighterX && treasureY > fighterY && treasureX + 41 > fighterX && treasureY < fighterY +51){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440);
     }
     if (treasureX > fighterX && treasureY < fighterY && treasureX < fighterX + 51 && treasureY + 41 > fighterY){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440);
     } 
     if (treasureX > fighterX && treasureY > fighterY && treasureX < fighterX + 51 && treasureY < fighterY +51){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX < fighterX && treasureX + 41 > fighterX && treasureY == fighterY){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX > fighterX && fighterX + 51 > treasureX && treasureY == fighterY){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX == fighterX && fighterY > treasureY && fighterY+51 < treasureY){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if (treasureX == fighterX && fighterY < treasureY && fighterY >treasureY+41){
       if(hpX<=205){hpX = hpX + (205-10)*10/100;}
       treasureX = random(600);
       treasureY = random(440); 
     }
     if(hpX>=205){
       hpX=205;
     }

      
   //when to gameover
     if (hpX <= 10){
       gameState = GAME_LOSE;
       
       
       //X, first & second 
       for(int i=0; i<5; i++){      //assign x coordinate in first enemy
            enemyFirstX[i] = 0-i*61;
            enemySecondX[i] = (0-640-61*5)-i*61;
       }
      //X, third
      for(int i=0; i<8; i++){
         if (0<=i && i<=4){
            enemyThirdX[i] = (0-640-61*5)*2-i*61;
         }else if(5<=i && i<=7){
            enemyThirdX[i] = (0-640-61*5)*2-(i-4)*61;
         }
      }
      
      //enemyDetecor
      enemyDetectorFirst = enemyFirstX[4];
     //   println(enemyDetectorFirst);
      enemyDetectorSecond = enemySecondX[4];
     //   println(enemyDetectorSecond);
      enemyDetectorThird = enemyThirdX[4];
     //   println(enemyDetectorThird);
 
     //Y
      enemyFirstY[0] = random(420);
      enemySecondY[0] = random(175); //480-61*5=175
      enemyThirdY[0] = random(122,297); //61*2=128; 480-61*3=297 
      
    //Y, first & second
    for(int i=1; i<5; i++){
      enemyFirstY[i] = enemyFirstY[0];
      enemySecondY[i] = enemySecondY[0]+i*61;
    }
    //Y, third
    enemyThirdY[1]= enemyThirdY[0]-61*1;
    enemyThirdY[2]= enemyThirdY[0]-61*2;
    enemyThirdY[3]= enemyThirdY[0]-61*1;
    enemyThirdY[4]= enemyThirdY[0];
    enemyThirdY[5]= enemyThirdY[0]+61*1;
    enemyThirdY[6]= enemyThirdY[0]+61*2;
    enemyThirdY[7]= enemyThirdY[0]+61*1;
       
    hpX = (205-10)*20/100;
    fighterX = 589;
    fighterY = 214.5;
}
     break;
          
      
 case GAME_LOSE:
      image(end2, 0, 0);
      if (mouseX >= width*96/300 && mouseX <= width*205/300 && mouseY >= height*257/400 && mouseY <= height*292/400){
        image(end1, 0, 0);
      }else{
        image(end2, 0, 0);
      }
      //click to restart
      if (mousePressed){
        if (mouseX >= width*96/300 && mouseX <= width*205/300 && 
            mouseY >= height*257/400 && mouseY <= height*292/400){
            gameState = GAME_RUN;
          }
      }
  }
}


void keyPressed(){
  if (key==CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}


void keyReleased(){
  if (key==CODED){
      switch(keyCode){
        case UP:
          upPressed = false;
        break;
        case DOWN:
          downPressed = false;
        break;
        case LEFT:
          leftPressed = false;
        break;
        case RIGHT:
          rightPressed = false;
        break;
      }
  }
}
