# Prompts utilizados — Laboratorio 06

## Herramienta utilizada

ChatGPT

## Ejercicio 4 — Calculadora de Venta a Plazos de Electrodoméstico

### Contexto

Soy estudiante de Programación en Móviles Avanzado y estoy trabajando en la semana 6 con UIKit, navegación entre ViewControllers, segues y paso de datos entre pantallas.

### Tarea

Necesito desarrollar una aplicación llamada VentaPlazos con dos pantallas.

La primera pantalla debe llamarse "Nueva Venta" y debe permitir ingresar:

- Nombre del electrodoméstico
- Precio unitario
- Cantidad
- Número de meses
- Tasa de interés mensual

La segunda pantalla debe llamarse "Resultado" y debe mostrar:

- Subtotal
- IGV
- Base
- Intereses
- Total
- Cuota mensual

También debo crear una clase VentaModel para guardar los resultados y pasar los datos a la segunda pantalla.

### Restricciones

Solo debo utilizar conceptos vistos hasta la semana 6:

- Clases
- UIViewController
- IBOutlet
- IBAction
- UINavigationController
- Segue de tipo Show
- prepare(for:sender:)

No debo utilizar:

- Combine
- Codable
- Persistencia
- Tecnologías no vistas en clase

### Formato

Quiero el código en Swift usando UIKit.

El segue debe llamarse:

showResultado

VentaModel debe ser una clase que herede de NSObject.

Los valores de resultado deben mostrarse en soles usando:

String(format: "S/. %.2f", valor)

### Ejemplo

Si ingreso:

Precio unitario: 3500
Cantidad: 1
Meses: 12
Interés mensual: 1

El resultado esperado es:

Subtotal: S/. 3500.00
IGV: S/. 630.00
Base: S/. 4130.00
Intereses: S/. 495.60
Total: S/. 4625.60
Cuota mensual: S/. 385.47

## Respuesta de la IA

La IA propuso crear una clase VentaModel con las seis propiedades necesarias para guardar los resultados. También indicó cómo conectar los controles del Storyboard, crear el segue Show con el identifier showResultado y utilizar prepare(for:sender:) para enviar el modelo a la segunda pantalla.

## ¿Funcionó a la primera?

No completamente. Durante el desarrollo tuve que corregir algunos detalles de conexión entre los controles del Storyboard y el código, además de agregar la propiedad venta en ViewControllerResultado para recibir el modelo.

## ¿Usó algo que no hemos visto en clase?

No. La solución se mantuvo usando UIKit, clases, IBOutlet, IBAction, segues y prepare(for:sender:), que corresponden a los temas de la semana.

## ¿Qué hizo distinto la IA?

La IA organizó el desarrollo por pasos, primero creando la interfaz, luego el modelo y finalmente el paso de datos entre las dos pantallas.

## Reflexión

La IA me ayudó a avanzar más rápido en la estructura del ejercicio, pero igual tuve que revisar las conexiones del Storyboard y entender cómo se pasaban los datos entre ViewControllers para poder corregir los errores que aparecieron.