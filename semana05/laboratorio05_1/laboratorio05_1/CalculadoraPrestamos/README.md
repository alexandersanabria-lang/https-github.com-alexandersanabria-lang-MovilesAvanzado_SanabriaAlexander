# Calculadora de Préstamos

Aplicación desarrollada en Swift con UIKit que permite calcular la cuota mensual de un préstamo y el monto total a pagar según el capital, la tasa de interés anual y el plazo ingresado.

## Requerimientos Funcionales

### RF01 - Ingresar capital
El sistema debe permitir ingresar el monto del préstamo.

### RF02 - Ingresar tasa de interés
El sistema debe permitir ingresar la tasa de interés anual en porcentaje.

### RF03 - Ingresar plazo
El sistema debe permitir ingresar el plazo del préstamo en años.

### RF04 - Validar datos ingresados
El sistema debe verificar que el capital, la tasa de interés y el plazo sean mayores que cero.

Si algún valor no es válido, debe mostrar:

"Por favor, ingresa valores válidos."

### RF05 - Calcular la tasa mensual
El sistema debe convertir la tasa de interés anual en una tasa mensual.

### RF06 - Calcular el número total de pagos
El sistema debe calcular la cantidad de pagos multiplicando el plazo en años por 12.

### RF07 - Calcular la cuota mensual
El sistema debe calcular la cuota mensual utilizando el capital, la tasa mensual y el número de pagos.

Fórmula:

M = P × [r(1+r)^n] / [(1+r)^n - 1]

Donde:

- M = cuota mensual
- P = capital
- r = tasa mensual
- n = número total de pagos

### RF08 - Calcular el monto total
El sistema debe calcular el monto total a pagar multiplicando la cuota mensual por el número total de pagos.

### RF09 - Mostrar cuota mensual
El sistema debe mostrar la cuota mensual calculada con dos decimales.

### RF10 - Mostrar monto total
El sistema debe mostrar el monto total a pagar con dos decimales.

### RF11 - Mostrar valores iniciales
Al iniciar la aplicación se debe mostrar:

Cuota mensual: -

Monto total a pagar: -

### RF12 - Ejecutar el cálculo
El sistema debe realizar el cálculo cuando el usuario presione el botón correspondiente.