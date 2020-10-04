//para colisión comparar bit a bit.

//Número de filas y columnas tal que (ROWS+1)(COLS+2)<32
final int ROWS=4;
final int COLS=4;

//Crea una entero para representar el tablero
int tablero=0;
//Guarda la posición de la primera rotación en todos los tetrominos
int pos=4;

//Información de cada tetromino
//Color, posX, posY, Posición de rotación0 +4, Rotación 0, Rotación 1...
int [] T = {#FF007D, 0,-3, 4, 114, 610, 624, 562};
int [] I = {#38FAEE, 0,-3, 4, 240, 8738};
int [] J = {#383CFA, 0,-3, 4, 550, 1136, 802, 113};
int [] L = {#FFA939, 0,-3, 4, 547, 116, 1570, 368};
int [] S = {#70FF39, 0,-3, 4, 54, 561};
int [] Z = {#FF1F1F, 0,-3, 4, 99, 612};
int [] O = {#E60DFF, 0,-3, 4, 51};

//Lista con todos los tetrominos
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int numTetro=0;
//Lleva la cuenta de cuántos tetrominos hay en el tablero menos 1
int []letraTetroList=new int[ROWS*COLS];
//Guarda los Tetros que han aparecido
int letraTetro= int(random(7));
//Guarda el tetro actual(en movimiento)
int time=0;//Lleva cuenta del tiempo


void setup() {
  size(600, 600);
  //frameRate(0.5);
  tablero= resetTablero(binary(tablero),ROWS,COLS);
  printBitwise(binary(tablero),ROWS+1,COLS+2);
  letraTetroList[0]=letraTetro;
}

void draw() {
  background(125);
  for(int i=0;i<=numTetro;i++){
    drawTetrominoe(Tetrominoes[letraTetroList[i]]);
    fallTetrominoe(Tetrominoes[letraTetro]);
  }
}

boolean collision(int[] A){
  print(binary(tablero),"\n",binary(A[A[pos-1]]),"\n");

  //tablero ROWS+1 x COLS+2
  int row=0, col=0, posTablero;
  //Matriz=tablero. A=Tetromino posición original
  print("\n collision \n");
  for (int i = 0; i < 16; i++) {
    col=i%4;
    row=(i-col)/4;

    if (row+A[2]<0){continue;}//Pos y A[2] Pos x A[1]
    print("\n row =", row," col =", col);
    posTablero=(A[2]+row)*(COLS+2)+col+1;
    //print(" posTablero =", posTablero);
    //print( binary(tablero), binary(1<< (ROWS+1)*(COLS+2) - posTablero),
            //tablero, 1<< (ROWS+1)*(COLS+2)-1 - posTablero, posTablero);
    if (( A[A[pos-1]] & (1 << 15 - i)) != 0) {
      if ( ( tablero  & (1<< (ROWS+1)*(COLS+2)-1 - posTablero))  != 0){
        print(" :3");
        return false;
      }
      //print("\n tablero << (ROWS+1)*(COLS+2)-1 - posTablero :",
      //tablero << (ROWS+1)*(COLS+2)-1 - posTablero);
    }
  }
  print("\n A[1] =",A[1],"\n \n");
  return true;
}


void fallTetrominoe(int[] A) {
  if(millis()>1500*time && collision(A)==true){//Si pasan 600 milisegundos
    time++;
    A[2]++;//Modifica altura
  }else if(collision(A)==false){
    A[2]--;
    numTetro++;//Baja un nuevo tetromino
    letraTetro=int(random(7));
    if (numTetro>=letraTetroList.length){
      //Si no pueden haber más tetrominos, empieza de nuevo
      numTetro=0;
      background(0);
    }
    letraTetroList[numTetro]=letraTetro;
  }
}

int resetTablero(String tablero, int rows,int cols){
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
  print("print Bitwise:",integer,"\n");
  for (int i=integer.length()-rows*cols;i<integer.length();i++){
    //print(" ",i," ");
    print(integer.charAt(i));
    if((i-integer.length()+1)%cols==0){
      print(" \n");
    }
  }
  print("\n");
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
    fill(A[0]);
  }
  pop();
  print("\n A[1] =",A[1],"\n");
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
    }else if (keyCode == SHIFT){noLoop();
    }else if (keyCode == CONTROL){loop();}
    if (Tetrominoes[letraTetro][pos-1] < pos) {
      Tetrominoes[letraTetro][pos-1]=Tetrominoes[letraTetro].length-1 ;
    }if(Tetrominoes[letraTetro][1]<-3){
      Tetrominoes[letraTetro][1]=ROWS-1;
    }else if(ROWS-1<Tetrominoes[letraTetro][1]){
      Tetrominoes[letraTetro][1]=-3;
    }

  }
}
