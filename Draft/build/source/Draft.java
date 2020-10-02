import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Draft extends PApplet {

//Número de filas y columnas
final int ROWS=20;
final int COLS=10;

//Crea una matriz de ROWSxCOLS
int [][] tableau = new int [ROWS][COLS];
//Guarda la posición de la primera rotación en todos los tetrominos
int pos=4;

//Información de cada tetromino
//Color, posX, posY, Posición de rotación+2, Rotación 0, Rotación 1...
int [] T = {0xffFF007D, 0,-2, 2, 114, 610, 624, 562};
int [] I = {0xff38FAEE, 0,-2, 2, 240, 8738};
int [] J = {0xff383CFA, 0,-2, 2, 550, 1136, 802, 113};
int [] L = {0xffFFA939, 0,-2, 2, 547, 116, 1570, 368};
int [] S = {0xff70FF39, 0,-2, 2, 54, 561};
int [] Z = {0xffFF1F1F, 0,-2, 2, 99, 612};
int [] O = {0xffE60DFF, 0,-2, 2, 51};

//Lista con todos los tetrominos
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int tetro = PApplet.parseInt(random(7));
int t=0;//Lleva cuenta del tiempo


public void setup() {
  
}

public void draw() {
  background(125);
  drawTetrominoe();
}

public void drawTetrominoe() {
  push();
  strokeWeight(5);
  fill(Tetrominoes[tetro][0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i <= 15; i++) {
    //value<<n value to shift n: number of places to shift
    if ( ( Tetrominoes[tetro][Tetrominoes[tetro][pos-1]] & (1 << 15 - i) ) != 0) {
      //& Compara bit por bit: si son iguales->1 si son diferentes ->0
      rect( (i % 4)*width/ROWS+Tetrominoes[tetro][1]*width/ROWS,
            (i/4+Tetrominoes[tetro][2])* width/ROWS,
            width/ROWS,
            width/ROWS);
    }
  }
  pop();
  if(millis()>600*t){
    t++;
    Tetrominoes[tetro][2]++;
  }if(Tetrominoes[tetro][2]>ROWS){
    Tetrominoes[tetro][2]=-2;
    Tetrominoes[tetro][1]=PApplet.parseInt(random(ROWS-3));
    tetro=PApplet.parseInt(random(7));
    background(0);
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Tetrominoes[tetro][pos-1]--;
    } else if (keyCode == DOWN) {
      Tetrominoes[tetro][2]++;
    }else if (keyCode == RIGHT) {
      Tetrominoes[tetro][1]++;
    }else if (keyCode == LEFT) {
      Tetrominoes[tetro][1]--;
    }
    if (Tetrominoes[tetro][pos-1] < pos) {
      Tetrominoes[tetro][pos-1]=Tetrominoes[tetro].length-1 ;
    }
    else {
      Tetrominoes[tetro][pos-1]=(Tetrominoes[tetro][pos-1]-pos) % (Tetrominoes[tetro].length-pos) +pos;
    }
  }
}
  public void settings() {  size(600, 750); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Draft" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
