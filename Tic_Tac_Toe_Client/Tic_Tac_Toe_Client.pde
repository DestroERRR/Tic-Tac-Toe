//Client - 1s (o's)
import processing.net.*;
Client myClient;

int[][] grid;
int go = 1;

void setup() {
  size(300, 400);
  
  
  grid = new int[3][3];
  strokeWeight(3);
  textAlign(CENTER, CENTER);
  textSize(50);
  
  myClient = new Client(this, "127.0.0.1", 1234);
  
}

void draw() {
  background(255);
println(go);
  //draw dividing lines
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);

  //draw the x's and o's
  int row = 0;
  int col = 0;
  while (row < 3) {
   
    drawXO(row, col);
   
    col++;
    if (col == 3) {
      col = 0;
      row++;
    }
  }



  //draw mouse coords
  fill(0);
  text(mouseX + "," + mouseY, 150, 350);
 
    
 
  //Receiving messages
  if(myClient.available() > 0) {
    String incoming = myClient.readString();
    int r = int(incoming.substring(0,1));
    int c = int(incoming.substring(2,3));
    grid[r][c]=2;
    go = 2;
  
  }
 
 if(go == 2){
   fill(0,200,0);      
   rect(10,350,20,30);
 } else if (go == 1){
  fill(200,0,0);
  rect(10,350,20,30);
 }
 
 
}


void drawXO(int row, int col) {
  pushMatrix();
  translate(row*100, col*100);
  if (grid[row][col] == 1) {
    fill(255);
    ellipse(50, 50, 90, 90);
  } else if (grid[row][col] == 2) {
    line (10, 10, 90, 90);
    line (90, 10, 10, 90);
  }
  popMatrix();
}


void mouseReleased() {
  //assign the clicked-on box with the current player's mark
  int row = (int)mouseX/100;
  int col = (int)mouseY/100;
  if (grid[row][col] == 0 && go == 2){ //when go is 2, it is the client's turn
    grid[row][col] = 1;
    myClient.write(row + "," + col);
    println(row + "," + col);
    go = 1;
  }
}
