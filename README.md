# Tetris
## Juego
 Juego clásico de Tetris en programación estructurada y bitwise.
 
 Figuras llamadas **tetrominos**, compuestas por cuatro bloques, se deplazan hacia abajo en un tablero hasta que llegan al fondo o se encuentran con otro tetromino.
 
 La idea es usar los controles para modificar el tetromino y que este al bajar complete filas.
 
 Una vez una fila es completada, esta desaparece y los bloques superiores descienden una fila.
 
 La partida se termina cuando un tetromino no puede entrar completamente al tablero gracias a los tetrominos debajo de él.
 
## Controles
El juego empieza automáticamente con el programa.

Cuando se oprime 

#### &uarr; flecha superior
Los tetrominos rotan.

#### &larr; flecha izquierda
 Los tetrominos se desplazan hacia la izquierda.
 
#### &rarr; flecha derecha
 Los tetrominos se desplazan hacia la derecha.

#### &darr; flecha inferior
Los tetrominos bajan a mayor velocidad.

#### ctrl 
El juego para, incluido para exponer el juego fácilmente
#### shift
El juego continua, incluido para exponer el juego fácilmente

## Lenguaje y archivo
 El juego está en el archivo Tetris\Tetris.pde y fue escrito en Processing Java.
 ## Representación en Bitwise
 Este juego representa el tablero, las rotaciones y posiciones de los tetrominos mediante los bits de un entero.
 ### Rotaciones de los tetrominos
 Las rotaciones de cada tetromino se pueden presentar como matrices binarias, las cuales, cuando son organizadas en un número binario continuo, representan a un entero.
 
 Por ejemplo, el Tetromino comúnmente referido como `O` puede ser representado por el entero `51`, ya que:
 
 La representación binaria de `51` es ` 0000000000110011`, si esta se organiza como una matriz de 4x4, se obtiene:
 ```
 0000
 0000
 0011
 0011
 ```
 Donde los `1` representan los bloques del tetromino.
 ### Tablero
 El tablero y sus límites están guardados usando la misma estrategia. 
 
Por ejemplo, para inicializar un tablero de 4x4 con sus límites usamos la matriz
```
100001
100001
100001
100001
111111
```
 equivalente a `100001100001100001100001111111` y representada por el número `562436223`, donde los `1` son los *límites* o *exterior* del tablero y los `0` son el *interior* del tablero.
### Ubicación de los tetrominos
Las posiciones de los tetrominos fijos se guardan en un tablero modificado.

La ubicación de los tetrominos en movimiento se guarda en variables más fáciles de manipular.

Cuando un tetromino se queda quieto, la información de su ubicación es guardada en el tablero, de acuerdo al siguiente ejemplo:

Usemos con el tetromino `O` y el tablero original, supongamos que la matriz del tetromino se ubica perfectamente en el *interior* del tablero
 ```
 0000
 0000
 0011
 0011
  +
100001
100001
100001
100001
111111
  =
100001
100001
100111
100111
111111
```

## Limitaciones 

En Java usamos el operador `<<` para acceder a cada bit, sin embargo, este operador devuelve únicamente enteros (datos tipo `int`), lo cual significa que si se utiliza en datos de mayor tamaño, se pierde información.

Como el tablero debe ser representado por un entero, es decir, máximo 32 bits y como también se tienen que representar los límites del tablero entonces sea cols el número de columnas del tablero y sea rows el número de filas del tablero, para que el código actual funcione se debe cumplir que 
```
(rows+1)(cols+2)<32
```
## A futuro y en desarrollo

* La función de dibujar los tetrominos fijos recae en una lista por tetromino, tal que cuando debe aparecer dos veces el mismo tetromino, solo aparece una vez. 
Esta función va a estar a cargo del tablero, el cual ya tiene la información, solo le falta dibujarla.
* Una vez se tenga lo anterior, eliminar una fila completada y reorganizar el trablero de acuerdo con ello.
* Utilizar otro tipo de dato (eg. `long`) para representar el tablero, con esto el tablero podría tener dimensiones más cómodas
* Añadir interfaz de usuario y sistemas de puntuación.
