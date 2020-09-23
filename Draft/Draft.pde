// Lo que hice fue que cuando se detectara que debajo de la ficha había otra ficha (o un cuadro de la ficha llego a y =1, o sea, el fondo del tablero), al presionar abajo o cuando se complete el tiempo, la ficha copiase su ubicación al tablero, de tal manera que se vea que está ahí. Luego de eso, se cambia el codigo de ls ficha y se reinician las coordenadas
//Cada cuadradito es un bit
//color,rotationValue,rotation1,...;
int [] T = {#FF007D,2, 114, 610, 624, 562};
int [] I = {#38FAEE,2, 240, 8738};
int [] J = {#383CFA,2, 550, 1136, 802, 113};
int [] L = {#FFA939,2, 547, 116, 1570, 368};
int [] S = {#70FF39,2, 54, 561};
int [] Z = {#FF1F1F,2, 99, 612};
int [] O = {#E60DFF,2, 51};
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int [] B;
int n = int(random(7));
// T tetromino properties


void setup() {
  size(600, 600);
}

void draw() {
  background(125);
  drawTetrominoe( Tetrominoes[n] );
}

void drawTetrominoe(int[] A) {
  B=A;
  push();
  strokeWeight(5);
  fill(A[0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i <= 15; i++) {
    //value<<n value to shift n: number of places to shift
    if ( ( A[A[1]] & (1 << 15 - i) ) != 0) {
      //& Compara bit por bit: si son iguales->1 si son diferentes ->0
      rect( (i % 4) * width / 4, ((i / 4) | 0) * height / 4, width / 4, height / 4);
    }
  }
  pop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      B[1] ++;
      println("B[1]++ =", B[1]);
    } else if (keyCode == DOWN) {
      B[1] --;
      println("B[1]-- =", B[1]);
    }
    else if (keyCode == RIGHT) {
      n= int(random(7));
    }
    println("B.length",B.length," Pos.rotación", B[1],
    "=", B[1] % (B.length-2));

    //B[1] = (B[1] < 2) ? B.length-3 : B[1] % (B.length-2) +2;
    if (B[1] < 2) B[1]=B.length-1 ;
    else B[1]=(B[1]-2) % (B.length-2) +2;

    println("B.length",B.length," Pos.rotación", B[1],
    "=", B[1] % (B.length-2));
    println("B[1] =", B[1]);
    println();
  }
}
