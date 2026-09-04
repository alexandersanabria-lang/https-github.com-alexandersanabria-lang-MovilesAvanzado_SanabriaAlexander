# Prompts — Lab 03
## Docente: Juan Leon — Tecsup
## Herramienta: Claude

## Ejercicio 6 — Gestión de notas

### Prompt (CTRFE):

**CONTEXTO:** Soy estudiante de iOS en la semana 3 del curso, acabo de aprender
Arrays, Diccionarios y Sets en Swift dentro de un Playground (sin usar struct,
class ni funciones custom todavía).

**TAREA:** Necesito un sistema que registre N alumnos con 3 notas cada uno en un
diccionario [String: [Double]], calcule el promedio de cada alumno y lo clasifique
con un switch (Excelente 17-20, Bueno 14-16, Aprobado 13, Desaprobado menos de 13).
También debe mostrar estadísticas generales (promedio general, nota más alta,
nota más baja, porcentaje de aprobados) y un ranking ordenado de mayor a menor
promedio.

**RESTRICCIONES:** Solo usar conceptos de las semanas 1 a 3 (variables, Arrays,
Diccionarios, Sets, bucles for-in, switch, readLine()). NO usar struct, class,
funciones personalizadas ni closures avanzados. Todo debe correr en un Playground
con entrada interactiva del usuario.

**FORMATO:** Código Swift con un comentario explicando qué hace CADA línea.

**EJEMPLO:** Un caso simple sería un diccionario ["Ana": [18, 19, 17]] que al
calcular el promedio (18.0) lo clasifique como "Excelente".

## Ejercicio 7 — Inventario con menú

### Prompt (CTRFE):

**CONTEXTO:** Mismo curso y semana que el ejercicio anterior, ya tengo un
diccionario de productos con nombre, precio y stock.

**TAREA:** Necesito un menú interactivo controlado por un bucle while que
muestre 5 opciones (Ver inventario, Buscar producto, Stock bajo, Valor total,
Salir) y siga repitiéndose hasta que el usuario elija la opción de salir.

**RESTRICCIONES:** Solo conceptos de semanas 1-3, sin struct/class. El menú debe
usar switch para evaluar la opción elegida y una variable booleana (bandera)
para controlar el while.

**FORMATO:** Código Swift comentado línea por línea.

**EJEMPLO:** Al elegir la opción "3", debe filtrar y mostrar solo los productos
con stock menor a 5 unidades.
