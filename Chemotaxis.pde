Bacteria [] Ghost = new Bacteria[4];
PowerUp [] PowerUps = new PowerUp[4];
whiteDot [] whiteDots = new whiteDot[100];
int repel = 1;
int endTime = 0;


 void setup()   
 {     
   int i = 0;
   size(500,500);
   rectMode(CENTER);
   textAlign(CENTER);
   PowerUps[0]= new PowerUp(25,25);
   PowerUps[1]= new PowerUp(475,25);
   PowerUps[2]= new PowerUp(25,475);
   PowerUps[3]= new PowerUp(475,475);
   Ghost[0] = new Bacteria(250, 0, color(255, 0,0));
   Ghost[1] = new Bacteria(0,250, color(0,255,0));
   Ghost[2] = new Bacteria(500,250, color(0,0,255));
   Ghost[3] = new Bacteria(250,500, color(255,255,0));
   for (int y = 25; y < 500; y += 50)
   {
     for (int x= 25; x < 500; x += 50)
     {
       whiteDots[i] = new whiteDot(x, y);
       i++;
     }
   }
 }   
 
 
 
 
 void draw()   
 {
   int count = 0;
   if (millis() > endTime && repel == (-1))
   {
     repel = repel * (-1);
   }
   background(0);
   fill(255,255,0);
   arc(mouseX,mouseY,50,50,0, PI + 3 * QUARTER_PI);
   for (int i = 0; i < whiteDots.length; i++)
   {
     whiteDots[i].show();
     if (whiteDots[i].exist == true)
     {
       count++;
     }
   }
   for (int i = 0; i < Ghost.length; i++) 
   {
     Ghost[i].walk();
     Ghost[i].show();
     PowerUps[i].show();
   }  
   if (count == 0)
   {
     winGame();
   }
 }
 
 class whiteDot
 {
   int myX,myY;
   boolean exist;
   whiteDot(int x, int y)
   {
     myX= x;
     myY = y;
     exist = true;
   }
   void show() {
     if(dist(mouseX,mouseY, myX, myY) < 8 && exist == true) 
     {
       exist = false;
     }
     if (exist == true)
     {
     fill(256, 256, 256);
     ellipse(myX, myY, 25,25);
     }
   }
 }
 class PowerUp
 {
   int myX, myY;
   boolean exist;
   PowerUp(int x, int y)
   {
     myX = x;
     myY = y;
     exist = true;
   }
   void show()
   {
     if(dist(mouseX,mouseY, myX, myY) < 7 && exist == true && repel != -1)
     {
       exist =false;
       Eaten();
     }
     if(exist == true)
     {
       fill(0,0,255);
       ellipse(myX,myY,25,25);
   }
   
 }
 }
     
 class Bacteria    
 {     
   int myX, myY, myColor, speed;
   Bacteria(int x, int y, int z)
   {
     myColor = z;
     myX = x;
     myY = y;
     speed = 5;
   }
   void walk()
   {
     speed = (dist(mouseX, mouseY, myX, myY) < 150) ? 8 : 5;
     if (myX > mouseX)
     {
       myX -= (repel) * ((int)(Math.random() * speed) - 1);
     }
     if (myX < mouseX)
     {
       myX += (repel) * ((int)(Math.random() * speed) - 1);
     }
     if (myY > mouseY)
     {
       myY -= (repel) * ((int)(Math.random() * speed) - 1);
     }
     if (myY < mouseY)
     {
       myY += (repel) * ((int)(Math.random() * speed) - 1);
     }
   }
   void show()
   {
     if(myX > 500)
       myX = 490;
     if(myX < 0)
       myX= 10;
     if(myY > 500)
       myY = 490;
     if(myY < 0)
       myY = 10;
     if (dist(mouseX,mouseY, myX, myY) < 8)
     {
       loseGame();
     }
     if (repel == 1) {
       fill(myColor);
       arc(myX, myY, 50, 80, PI, 2 * PI);
       fill(256, 256, 256);
       ellipse(myX - 10, myY -20, 10, 15);
       ellipse(myX + 10, myY - 20, 10, 15);
       fill(0,0,0);
       ellipse(myX - 10, myY - 18, 9, 9);
       ellipse(myX + 10, myY - 18, 9, 9);
     }
     if (repel == (-1))
     {
       fill(0,0,255);
       arc(myX, myY, 50, 80, PI, 2 * PI);
       fill(256,256,256);
       rect(myX - 10, myY - 20, 10,10);
       rect(myX + 10, myY-20, 10, 10);
     }
   }
 }
 
 
 void Eaten() 
 {
   endTime = millis() + 3000;
   repel = repel * (-1);
 }

void winGame() 
{
  noLoop();
  background(0,0,0);
  fill(256,256,256);
  text("You Win!", 250, 250);
}

void loseGame()
{
  noLoop();
  background(0,0,0);
  fill(256,256,256);
  text("You Lose :(", 250, 250);
}
