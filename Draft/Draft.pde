//Número de filas y columnas
final int ROWS=20;
final int COLS=10;

//Crea una matriz de ROWSxCOLS
int [][] tableau = new int [ROWS][COLS];
//Guarda la posición de la primera rotación en todos los tetrominos
int pos=2;

//Información de cada tetromino
//Color, Posición de rotación+2, Rotación 0, Rotación 1...
int [] T = {#FF007D,2, 114, 610, 624, 562};
int [] I = {#38FAEE,2, 240, 8738};
int [] J = {#383CFA,2, 550, 1136, 802, 113};
int [] L = {#FFA939,2, 547, 116, 1570, 368};
int [] S = {#70FF39,2, 54, 561};
int [] Z = {#FF1F1F,2, 99, 612};
int [] O = {#E60DFF,2, 51};

//Lista con todos los tetrominos
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int tetro = int(random(7));
int h=-2;//Altura
int w=int(random(0,ROWS-1));//Ubicación x
int t=0;


void setup() {
  size(600, 750);
}

void draw() {
  background(125);
  drawTetrominoe(Tetrominoes[tetro]);
}

void drawTetrominoe(int [] A) {
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
    w=int(random(ROWS-3));
    tetro=int(random(7));
    background(0);
  }
}

void keyPressed() {
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
