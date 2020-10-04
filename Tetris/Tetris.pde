//para colisión comparar bit a bit.

//Número de filas y columnas
final int ROWS=3;
final int COLS=4;

//Crea una entero bitwise para representar el tableau
int tableau=0;
//Guarda la posición de la primera rotación en todos los tetrominos
int pos=4;

//Información de cada tetromino
//Color, posX, posY, Posición de rotación+2, Rotación 0, Rotación 1...
int [] T = {#FF007D, 0,-2, 4, 114, 610, 624, 562};
int [] I = {#38FAEE, 0,-2, 4, 240, 8738};
int [] J = {#383CFA, 0,-2, 4, 550, 1136, 802, 113};
int [] L = {#FFA939, 0,-2, 4, 547, 116, 1570, 368};
int [] S = {#70FF39, 0,-2, 4, 54, 561};
int [] Z = {#FF1F1F, 0,-2, 4, 99, 612};
int [] O = {#E60DFF, 0,-2, 4, 51};

//Lista con todos los tetrominos
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int numTetro=0;//Lleva la cuenta de cuántos tetrominos hay en el tableau menos 1
int []letraTetroList=new int[ROWS*COLS/4];//Guarda los Tetros que han aparecido
int letraTetro= int(random(7));//Guarda el tetro actual(en movimiento)
int time=0;//Lleva cuenta del tiempo


void setup() {
  size(600, 750);

  tableau= resetTableau(binary(tableau),ROWS,COLS);
  printBitwise(binary(tableau),ROWS+1,COLS+2);
  //print(binary(tableau),"\n");
  //letraTetroList[0]=letraTetro;
}

void draw() {
  background(125);
  //noLoop();
  //for(int i=0;i<=numTetro;i++){
  //  drawTetrominoe(Tetrominoes[letraTetroList[i]]);
  //  fallTetrominoe(Tetrominoes[letraTetro]);
  //}
}

int resetTableau(String tablero, int rows,int cols){
  for (int i=0;i<rows;i++){
    tablero= tablero+"1";
    for (int j=0;j<cols;j++){
      tablero= tablero+"0";
    }
    tablero= tablero+"1";
  }
  for (int j=0;j<cols+2;j++){
    tablero= tablero+"1";
  }
  return unbinary(tablero);
}

void printBitwise(String integer,int rows,int cols){
  print(integer,"\n");
  for (int i=integer.length()-rows*cols;i<integer.length();i++){
    //print(" ",i," ");
    print(integer.charAt(i));
    if((i-integer.length()+1)%cols==0){
      print(" \n");
    }
  }
  print("\n hola \n");
}




void drawTetrominoe(int[] A) {
  push();
  strokeWeight(5);
  fill(A[0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i < 16; i++) {
    //value<<n value to shift n: number of places to shift
    if ( ( A[A[pos-1]] & (1 << 15 - i) ) != 0) {
      //& Compara bit por bit: si son iguales->1 si son diferentes ->0
      rect( (i % 4)*width/ROWS+A[1]*width/ROWS,
            (i/4+A[2])* height/COLS,
            width/ROWS,
            height/COLS);
    }
  }
  pop();
}
void fallTetrominoe(int[] A) {
  if(millis()>600*time){//Si pasan 600 milisegundos
    time++;
    A[2]++;//Modifica altura
  }if(A[2]>COLS-4){//Si la altura está por fuera del tableau
    A[2]--;//Revierte la altura
    numTetro++;//Baja un nuevo tetromino
    letraTetro=int(random(7));
    letraTetroList[numTetro]=letraTetro;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Tetrominoes[letraTetro][pos-1]--;
    } else if (keyCode == DOWN) {
      Tetrominoes[letraTetro][2]++;
    }else if (keyCode == RIGHT) {
      Tetrominoes[letraTetro][1]++;
    }else if (keyCode == LEFT) {
      Tetrominoes[letraTetro][1]--;
    }
    if (Tetrominoes[letraTetro][pos-1] < pos) {
      Tetrominoes[letraTetro][pos-1]=Tetrominoes[letraTetro].length-1 ;
    }if(Tetrominoes[letraTetro][1]<-3){
      Tetrominoes[letraTetro][1]=ROWS-1;
    }else if(ROWS-1<Tetrominoes[letraTetro][1]){
      Tetrominoes[letraTetro][1]=-3;
    }

  }
}
