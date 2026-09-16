# Prompts utilizados — Laboratorio 04

## Herramienta de IA utilizada

ChatGPT

## Caso 2B — Biblioteca

### Prompt 1:

Soy estudiante de Swift, cuarta semana, y estoy trabajando en un Playground de Xcode.

Necesito desarrollar una biblioteca utilizando Programación Orientada a Objetos en Swift.

Debo utilizar:
- enum EstadoLibro con disponible y prestado.
- struct Libro con titulo, autor y estado.
- class Biblioteca con un array de libros.
- método agregar(libro:).
- método prestar(titulo:) -> Bool.
- método devolver(titulo:) -> Bool.
- método inventario().

Para buscar libros debo utilizar un bucle por índices con:

for i in 0..<libros.count

Para mostrar el estado de cada libro debo utilizar switch.

Restricciones:
No utilizar optionals, guard let, firstIndex(where:), didSet, propiedades calculadas ni genéricos.

La simulación debe:
1. Agregar Cien años de soledad, La ciudad y los perros y El Quijote.
2. Prestar La ciudad y los perros.
3. Intentar prestarlo nuevamente.
4. Devolver La ciudad y los perros.
5. Prestar El Quijote.
6. Intentar prestar El Principito, que no existe.
7. Mostrar el inventario final.

Comenta el código línea por línea de manera sencilla para que pueda explicar qué hace.

### Respuesta de la IA:

La IA generó una solución usando un enum para el estado, un struct para representar cada libro y una clase Biblioteca para administrar el arreglo. También utilizó recorridos por índice, condicionales y switch para controlar los préstamos, devoluciones y el inventario.

### ¿Funcionó a la primera?

Sí. La solución respetó las restricciones solicitadas y produjo la salida esperada.

### ¿Usó algo que no hemos visto en clase?

No. Se utilizaron enums, structs, clases, arrays, funciones, bucles, condicionales y switch.

## Mi versión (Parte A) vs. la versión de la IA (Parte B)

### ¿Qué hizo distinto la IA respecto a mi solución?

La lógica principal fue parecida porque ambas versiones tenían que cumplir el mismo enunciado. La versión de la IA separó primero los libros en variables antes de agregarlos a la biblioteca y agregó comentarios más detallados en cada parte del código.

### ¿Hay alguna línea de la IA que no entiendo del todo? ¿Cuál?

Entiendo las líneas utilizadas porque trabajan con conceptos vistos en clase. La parte más importante fue comprender que libros[i].estado modifica directamente el Libro que se encuentra dentro del array.

### ¿Qué me pareció mejor de MI versión?

Mi versión fue más directa y me permitió resolver el ejercicio aplicando personalmente los conceptos vistos en clase.

### ¿Qué me pareció mejor de la versión de la IA?

La versión de la IA tiene comentarios más detallados que ayudan a identificar rápidamente qué hace cada parte del programa.
