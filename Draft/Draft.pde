

//Número de filas y columnas
final int ROWS=3;
final int COLS=4;

//Crea una matriz de ROWSxCOLS,valores se incializan en 0
int [][] tableau = new int [ROWS][COLS];
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
int tetro = int(random(7));
int t=0;//Lleva cuenta del tiempo


void setup() {
  size(600, 750);
  randomFill(tableau);
  print(tableau);
  removeRow(0,tableau);
  print(tableau);

}

void draw() {
  background(125);
  //drawTetrominoe(Tetrominoes[tetro]);
}

void drawTetrominoe(int[] A) {
  push();
  strokeWeight(5);
  fill(A[0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i <= 15; i++) {
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
  if(millis()>600*t){
    t++;
    A[2]++;
  }if(A[2]>ROWS){
    A[2]=-2;
    A[1]=int(random(ROWS-3));
    tetro=int(random(7));
    background(0);
  }
}

void keyPressed() {
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
    }if(Tetrominoes[tetro][1]<-3){
      Tetrominoes[tetro][1]=ROWS-1;
    }else if(ROWS-1<Tetrominoes[tetro][1]){
      Tetrominoes[tetro][1]=-3;
    }

  }
}
//Función imprimir matriz
void print(int matrix [][]){
  for (int i=0; i<matrix.length; i++){
    print("row",i,"\n");
    println(matrix[i]);
  }
}

//Para matrices rectangulares
//Remover fila y devolver matriz modificada
int[][]removeRow(int delRow,int matrix[][]){
  int rows=matrix.length;
  int cols=matrix[0].length;
  print("rows",rows);
  if (delRow<0||delRow>=rows){
    throw new Error("removeRow out of bounds");
  }
  int counter=0;
  int [][] matrix1 = new int [rows][cols];
  //for(int i=0;i<rows;i++){
  //  //if (delRow==i){i++;}
  //  for(int j=0;j<cols;j++){
  //    matrix1[i][j]=matrix[i][j];
  //  }
  //  counter++;
  //}
  print (matrix1);
  return matrix1;
}

void randomFill(int matrix[][]){
  int rows=matrix.length;
  int cols=matrix[0].length;
  for(int i=0;i<rows;i++){
    for(int j=0;j<cols;j++){
      matrix[i][j]=int(random(100));
    }
  }
}
