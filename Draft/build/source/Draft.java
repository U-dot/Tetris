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
int pos=2;

//Información de cada tetromino
//Color, Posición de rotación+2, Rotación 0, Rotación 1...
int [] T = {0xffFF007D,2, 114, 610, 624, 562};
int [] I = {0xff38FAEE,2, 240, 8738};
int [] J = {0xff383CFA,2, 550, 1136, 802, 113};
int [] L = {0xffFFA939,2, 547, 116, 1570, 368};
int [] S = {0xff70FF39,2, 54, 561};
int [] Z = {0xffFF1F1F,2, 99, 612};
int [] O = {0xffE60DFF,2, 51};

//Lista con todos los tetrominos
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int tetro = PApplet.parseInt(random(7));
int h=-2;//Altura
int w=PApplet.parseInt(random(0,ROWS-1));//Ubicación x
int t=0;


public void setup() {
  
}

public void draw() {
  background(125);
  drawTetrominoe(Tetrominoes[tetro]);
}

public void drawTetrominoe(int [] A) {
  push();
  strokeWeight(5);
  fill(A[0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i <= 15; i++) {
    //value<<n value to shift n: number of places to shift
    if ( ( A[A[1]] & (1 << 15 - i) ) != 0) {
      //& Compara bit por bit: si son iguales->1 si son diferentes ->0
      rect( (i % 4)*width/ROWS+w*width/ROWS, (i/4+h)* width/ROWS, width/ROWS, width/ROWS);
    }
  }
  pop();
  if(millis()>600*t){
    t++;
    h++;
  }if(h>ROWS){
    h=-2;
    w=PApplet.parseInt(random(ROWS-3));
    tetro=PApplet.parseInt(random(7));
    background(0);
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Tetrominoes[tetro][1]++;
    } else if (keyCode == DOWN) {
      h++;
    }else if (keyCode == RIGHT) {
      w++;
    }else if (keyCode == LEFT) {
      w--;
    }
    if (Tetrominoes[tetro][1] < pos) {
      Tetrominoes[tetro][1]=Tetrominoes[tetro].length-1 ;
    }
    else {
      Tetrominoes[tetro][1]=(Tetrominoes[tetro][1]-pos) % (Tetrominoes[tetro].length-pos) +pos;
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
