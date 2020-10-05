import java.util.Arrays;
//Número de filas y columnas tal que (ROWS+1)(COLS+2)<32
final int ROWS=4;
final int COLS=4;
int tablero=0; //Crea una entero para representar el tablero
int pos=4;//Guarda la posición de la primera rotación en todos los tetrominos
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
int numTetro=0;//Número de tetrominos en el tablero menos 1
//Guarda las listas de los tetrominos que han aparecido
int []letraTetroList=new int[int(ROWS*COLS/4+2)];
int letraTetro= int(random(7));//Guarda el tetro actual(en movimiento)
int time=0;//Lleva cuenta del tiempo

void setup() {
  size(600, 600);
  tablero= resetTablero();//resetea el tablero
  printBitwise(binary(tablero),ROWS+1,COLS+2);//Imprime el tablero
  letraTetroList[0]=letraTetro;//Empieza con el primer tetromino
}

void draw() {
  background(125);
  for(int i=0;i<=numTetro;i++){//Dibuja cada tetromino que está en el tablero
    drawTetrominoe(Tetrominoes[letraTetroList[i]]);
  }//Revisa si el tetromino "actual" puede seguir bajando
  fallTetrominoe(Tetrominoes[letraTetro]);
}
void drawTetrominoe(int[] A) {//Dibuja el tetromino A
  push();
  strokeWeight(5);
  fill(A[0]);//A[0] guarda el color del tetromino
  for (int i = 0; i < 16; i++) {
    //Bitwise -Pinta un cuadradito si y solo si el bit es 1
    if ( ( A[A[pos-1]] & (1 << 15 - i) ) != 0) {
      rect( (i % 4)*width/ROWS+A[1]*width/ROWS,
            (i/4+A[2])* height/COLS,
            width/ROWS,
            height/COLS);
    }
  }
  pop();
}
void fallTetrominoe(int[] A) {//Revisa si el tetromino A puede bajar una fila
  //Si pasan 1500 milisegundos y no va a habler colisión
  if(millis()>1500*time && collision(A,0,1)==true){
    time++;//Aumeta el contadro de tiempo
    A[2]++;//Modifica altura
    //Si pasan 1500 milisegundos y sí va a habler colisión
  }else if(millis()>1500*time &&collision(A,0,1)==false){//No modifica altura
    newTablero(A);//Incluye la ubicación del tetromino en el tablero
    numTetro++;//Se usa un nuevo tetromino
    letraTetro=int(random(7));//Escoge el nuevo tetromino
    if (numTetro>=letraTetroList.length){//Si no pueden haber más tetrominos
      numTetro=0;//empieza de nuevo
      resetTablero();
      for (int[]i:Tetrominoes){A[1]=0; A[2]=-3;}
    }
    letraTetroList[numTetro]=letraTetro; //Anota el nuevo tetromino
  }
}
void newTablero(int[] A){//Incluye la ubicación del tetromino A en el tablero
  print(binary(tablero),"\n",binary(A[A[pos-1]]),"\n");//Imprime el tablero sin cambios
  char [] bTablero= binary(tablero).toCharArray();//Crea una lista de caracteres con los datos del tablero
  //Variables para calcular la posiciónque debe llevar cada bit de A en el tablero
  int row=0, col=0, posTablero;
  for (int i = 0; i < 16; i++) {
    col=i%ROWS;//Calcula posX o columna del bit en el tablero
    row=(i-col)/ROWS;//Calcula posY o columna del bit en el tablero
    if (row+A[2]<0){continue;}//Si el bit todavía no aparece, i
    posTablero=(A[2]+row)*(COLS+2)+col+3+A[1];//Calcula posición del bit de A en el tablero
    if (( A[A[pos-1]] & (1 << 15 - i)) != 0) {//Modifica el bit en el tablero si el bit de A es 1
      bTablero[posTablero]='1';
    }
  }
  tablero = unbinary(new String(bTablero));//Asigna el nuevo valor al tablero
  printBitwise(binary(tablero),ROWS+1,COLS+2);//Imprime el nuevo tablero
}

boolean collision(int[] A, int movX,int movY){
  //Calcula colisión con el tablero si A se mueve mov X en el eje x o movY en el eje y.
  //Variables para calcular la posiciónque debe llevar cada bit de A en el tablero
  int row=0, col=0, posTablero;
  for (int i = 0; i < 16; i++) {
    col=i%ROWS;
    row=(i-col)/ROWS;
    if (row+A[2]+movY<0){continue;}//Pos y A[2]+movY Pos x A[1]+movX
    posTablero=(A[2]+movY+row)*(COLS+2)+col+A[1]+movX+1;
    if (( A[A[pos-1]] & (1 << 15 - i)) != 0) {
      if ( ( tablero  & (1<< (ROWS+1)*(COLS+2)-1 - posTablero))  != 0){
        return false;
      }
    }
  }
  return true;
}
int resetTablero(){
  String aTablero= binary(tablero);
  for (int i=0;i<ROWS;i++){
    aTablero= aTablero+"1";
    for (int j=0;j<COLS;j++){
      aTablero= aTablero+"0";
    }
    aTablero= aTablero+"1";
  }
  for (int j=0;j<COLS+2;j++){
    aTablero= aTablero+"1";
  }
  return unbinary(aTablero);
}

void printBitwise(String integer,int rows,int cols){
  print("print Bitwise:",integer,"\n");
  for (int i=integer.length()-rows*cols;i<integer.length();i++){
    print(integer.charAt(i));
    if((i-integer.length()+1)%cols==0){
    }
  }
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Tetrominoes[letraTetro][pos-1]--;
    } else if (keyCode == DOWN) {
      Tetrominoes[letraTetro][2]++;
    }else if (keyCode == RIGHT) {
      int a = collision(Tetrominoes[letraTetro],1,0)==false? 0:1;
      Tetrominoes[letraTetro][1]+=a;
    }else if (keyCode == LEFT) {
      int b = collision(Tetrominoes[letraTetro],-1,0)==false? 0:-1;
      Tetrominoes[letraTetro][1]+=b;
    }else if (keyCode == SHIFT){noLoop();
    }else if (keyCode == CONTROL){loop();}
    if (Tetrominoes[letraTetro][pos-1] < pos) {
      Tetrominoes[letraTetro][pos-1]=Tetrominoes[letraTetro].length-1 ;
    }
  }
}
