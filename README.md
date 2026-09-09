# 🚇 MetroRuta Lima

Simulador académico de la red del Metro de Lima y Callao, desarrollado en **Swift** y ejecutado desde **Xcode Playground** o **Terminal**.

Permite explorar las 6 líneas del Metro, buscar estaciones, consultar enlaces cercanos entre líneas, planificar viajes (directos y combinados) y buscar lugares de interés asociados a estaciones.

## 📋 Descripción general

MetroRuta Lima simula la consulta y planificación de viajes dentro de una red compuesta por seis líneas del Metro de Lima y Callao. El sistema trabaja en modo de **simulación académica**: todas las líneas registradas (operativas o simuladas) pueden usarse por el planificador para demostrar la lógica del programa, aunque algunas correspondan a trazados futuros.

**Problema que resuelve:** una persona que no conoce la red puede tener dificultad para identificar qué línea usar, qué estaciones recorrer, dónde cambiar de línea o qué estación sirve como referencia para llegar a un lugar. El programa organiza esa información y la entrega desde una interfaz de texto.

## 🛠️ Base técnica

| Elemento | Implementación |
|---|---|
| Lenguaje | Swift |
| Archivo principal | `Contents.swift` |
| Ejecución | Xcode Playground o `swift` desde Terminal |
| Entrada | `readLine()` |
| Salida | `print()` |
| Colecciones | `Array`, `Dictionary`, `Set` |
| Modelado | `struct`, `enum` |
| Control de flujo | `if`, `switch`, `guard`, `for`, `while` |
| Control de versiones | Git / GitHub |

### Estructuras principales

- **`LineaMetro`** — número, nombre, estado, estaciones y descripción de cada línea.
- **`EstadoLinea`** *(enum)* — diferencia entre línea `.operativa` y línea `.simulada`.
- **`EnlaceCercano`** — relación entre una estación de una línea y una estación o acceso cercano de otra.
- **`LugarInteres`** — asocia un lugar conocido con una estación, una línea y palabras clave de búsqueda.

## 🗺️ Alcance funcional

Cubre las seis líneas registradas (L1 a L6). El planificador resuelve viajes directos (misma línea) y viajes entre líneas distintas, buscando una secuencia de líneas conectadas mediante enlaces cercanos (**BFS**). No usa base de datos ni servicios externos: toda la información está cargada en el código.

## ▶️ Cómo ejecutarlo

**Opción 1 — Xcode Playground**
1. Abre `MetroRutaLima.playground` en Xcode.
2. Ejecuta el playground y usa la consola para interactuar.

**Opción 2 — Terminal**
```bash
swift Semana03/Trenes-Lima/MetroRutaLima.playground/Contents.swift
```

## 📖 Menú principal

```
1. Ver líneas del Metro
2. Consultar estaciones de una línea
3. Buscar una estación
4. Consultar estado de una línea
5. Ver enlaces entre líneas
6. Planificar un viaje
7. Buscar lugar o referencia
8. Ver resumen de la red
0. Salir
```

## ✅ Requerimientos funcionales

| RF | Funcionalidad | Opción | Función principal | Resultado esperado |
|---|---|---|---|---|
| RF01 | Mostrar líneas del Metro | 1 | `mostrarLineas()` | Muestra L1–L6 |
| RF02 | Consultar estaciones de una línea | 2 | `mostrarEstacionesDeLinea(numero:)` | Lista ordenada de estaciones |
| RF03 | Buscar e informar una estación | 3 | `buscarEstacion(nombre:)` | Ficha de estación (línea, posición, vecinas, terminales) |
| RF04 | Consultar estado de una línea | 4 | `consultarEstadoLinea(numero:)` | Estado y descripción |
| RF05 | Mostrar enlaces cercanos entre líneas | 5 | `mostrarConexiones()` | Lista de enlaces |
| RF06 | Planificar una ruta directa | 6 | `consultarRuta(origen:destino:)` | Tramo dentro de la misma línea |
| RF07 | Planificar una ruta entre varias líneas | 6 | `buscarCaminoDeLineas(desde:hasta:)` | Ruta combinada con cambios por cercanía |
| RF08 | Elegir la ruta con menor cantidad de líneas | 6 | `buscarCaminoDeLineas(desde:hasta:)` (BFS) | Secuencia de líneas más corta |
| RF09 | Buscar lugares de interés | 7 | `buscarReferencia(_:)` | Lugar + estación recomendada |
| RF10 | Mostrar resumen de la red | 8 | `mostrarResumenRed()` | Totales de líneas, estaciones, enlaces y lugares |
| RF11 | Validar entradas del usuario | Todas | `leerNumero(mensaje:)`, `leerTextoNoVacio(mensaje:)` | No se cierra ante error |
| RF12 | Mantener ejecución interactiva | Todas | `ejecutarPrograma()` | Vuelve al menú tras cada consulta |

La búsqueda de estaciones y lugares es **insensible a mayúsculas, minúsculas y tildes** (`normalizarTexto(_:)`), por ejemplo `GAMARRA`, `gamarra` y `Gamarra` devuelven el mismo resultado.

## 🚦 Lógica del planificador de viajes

1. Identifica las líneas a las que pertenecen origen y destino.
2. Si comparten línea → **ruta directa**, respetando el orden de estaciones.
3. Si están en líneas distintas → busca la secuencia de líneas conectadas mediante `enlacesCercanos`, usando **BFS** (`buscarCaminoDeLineas`) para encontrar el camino más corto.
4. Cada cambio de línea se resuelve como un **cambio por cercanía**: baja en una estación y se dirige hacia el acceso o estación cercana de la siguiente línea.
5. Al final se muestra un resumen: líneas utilizadas, cantidad de cambios y destino.

## 🧪 Casos de prueba sugeridos

| Caso | Entrada | Resultado esperado |
|---|---|---|
| CP01 | Gamarra → Bayóvar | Ruta directa (L1) |
| CP02 | Puerto del Callao → Evitamiento | Ruta directa (L2) |
| CP07 | Bayóvar → Evitamiento | Ruta combinada (L1 → L2) |
| CP08 | Barranco → Aeropuerto | Ruta combinada (varias líneas) |
| CP09 | Universidad de Lima → Puerto del Callao | Ruta combinada (L6 → L2) |
| CP10 | "mall santa anita" | Lugar + estación recomendada |
| CP11 | GAMARRA | Normalización de mayúsculas |
| CP12 | Maria Auxiliadora | Normalización de tildes |
| CP13 | 99 en el menú | Mensaje de opción inválida |
| CP14 | "hola" donde se pide un número | Solicita el número nuevamente |

## ⚠️ Restricciones

- Funciona únicamente por consola; no usa SwiftUI ni UIKit.
- No usa base de datos ni API externa; los datos están definidos en el código.
- Las 6 líneas se usan como parte de una simulación académica (algunas son operativas, otras simuladas).
- Los enlaces cercanos representan una lógica de orientación del simulador, no necesariamente un transbordo físico dentro de una misma estación.

## 📂 Estructura del proyecto

```
Semana03/Trenes-Lima/MetroRutaLima.playground/
├── Contents.swift          # Lógica completa del simulador
└── contents.xcplayground
```

---
**Curso:** Programación en Móviles Avanzado · **Autor:** Alexander Sanabria
