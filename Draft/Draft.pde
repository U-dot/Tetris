// Lo que hice fue que cuando se detectara que debajo de la ficha había otra ficha (o un cuadro de la ficha llego a y =1, o sea, el fondo del tablero), al presionar abajo o cuando se complete el tiempo, la ficha copiase su ubicación al tablero, de tal manera que se vea que está ahí. Luego de eso, se cambia el codigo de ls ficha y se reinician las coordenadas
//Cada cuadradito es un bit
//color,rotationValue,rotation1,...;
int pos=2;
int [] T = {#FF007D,2, 114, 610, 624, 562};
int [] I = {#38FAEE,2, 240, 8738};
int [] J = {#383CFA,2, 550, 1136, 802, 113};
int [] L = {#FFA939,2, 547, 116, 1570, 368};
int [] S = {#70FF39,2, 54, 561};
int [] Z = {#FF1F1F,2, 99, 612};
int [] O = {#E60DFF,2, 51};
int[] [] Tetrominoes= {T, I, J, L, S, Z, O};
int [] B;
// T tetromino properties
int tetro = int(random(7));
int div= 8;//Número de divisiones
int h=-2;//Altura
int w=int(random(0,div-1));//Ubicación x
int t=0;


void setup() {
  size(600, 750);
}

void draw() {
  background(125);
  drawTetrominoe( Tetrominoes[tetro] ,tetro);
}

void drawTetrominoe(int [] A, int a) {
  B=A;
  push();
  strokeWeight(5);
  fill(A[0]);
  //Se encarga de pintar el cuadradito si se debe
  for (int i = 0; i <= 15; i++) {
    //value<<n value to shift n: number of places to shift
    if ( ( A[A[1]] & (1 << 15 - i) ) != 0) {
      //& Compara bit por bit: si son iguales->1 si son diferentes ->0
      rect( (i % 4)*width/div+w*width/div, (i/4+h)* width/div, width/div, width/div);
    }
  }
  pop();
  if(millis()>600*t){
    t++;
    h++;
  }if(h>div){
    h=-2;
    w=int(random(div-3));
    tetro=int(random(7));
    background(0);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      B[1] ++;
    } else if (keyCode == DOWN) {
      //B[1] --;
      h++;
    }
    else if (keyCode == RIGHT) {
      w++;
    }
    else if (keyCode == LEFT) {
      w--;
    }
    if (B[1] < pos) B[1]=B.length-1 ;
    else B[1]=(B[1]-pos) % (B.length-pos) +pos;
  }
}
