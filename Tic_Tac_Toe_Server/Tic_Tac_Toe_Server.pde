//Server (sends x's (2))
import processing.net.*;

Server myServer;


int [][] grid;
int go = 1;

void setup() { 
  myServer = new Server(this, 1234);
  
  // always goes row then collums 
  grid = new int [3][3];  //we start at row 0 collum 0 
  size(300,400);
  strokeWeight(2);
  textAlign(CENTER, CENTER);
  textSize(50);
  
  
  
  
  
  
  
  // grid[0][0] = 2;
  // grid[2][1] = 4;
  // grid[0][1] = 2;
   
}

void draw() {
  background(200);
  println(go);
  //drawing tic-tac toe lines 
  stroke(0);
  line(0, 100, 300, 100);
  line(0, 200, 300, 200);
  line(100, 0, 100, 300);
  line(200, 0, 200, 300);
 
  //drawing x's and o's 
 int row = 0;
 int col = 0;
 while (row < 3){
  //do something
 // print(grid[row][col]);
  
  drawXO(row, col);
  
  col++;
  
  if(col == 3){
    col = 0;
    row++;
    println(""); 
  }
  
 }
  
  
  
  //drawing mouse coords
fill(0);
text(mouseX + "," + mouseY, 150, 350);
  
 
  //Receiving messages
  Client myClient = myServer.available();
  if(myClient !=null) {
   String incoming = myClient.readString();
   int r = int(incoming.substring(0,1)); //goes to but not including 1; gets row 0
   int c = int(incoming.substring(2,3));
   grid[r][c] = 1;
   go = 1;
  }
  
 if(go == 1){
   fill(0,200,0);      // if go is 1 which means it is server's turn, notify them with green box
   rect(10,350,20,30);
 } else if (go == 2){
  fill(200,0,0);
  rect(10,350,20,30);
 }
 
 
  
  
}


void drawXO(int row, int col) {
 pushMatrix();
 translate(row*100, col*100);
 if(grid[row][col] == 1){
  fill(255);
  ellipse(50, 50, 90, 90); // this the o
 } else if (grid[row][col] == 2) {
  line (10, 10, 90, 90);
  line (90, 10, 10, 90);  // this is the x 
 }
 popMatrix();
 
 }
  
void mouseReleased() {
  //assign the clicked box with current player's mark 
  int row = (int)mouseX/100;  //because it is int, it chops off the decimals
  int col = (int)mouseY/100;
  if (grid[row][col] == 0 && go == 1){ // when go is 1, it is the server's turn
  grid[row][col] = 2;
  myServer.write(row + "," + col);
  println(row + "," + col);
  go = 2;
  }
}
