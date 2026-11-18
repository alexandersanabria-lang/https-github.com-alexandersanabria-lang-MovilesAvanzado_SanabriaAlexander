# PROMPTS.md — Lab 11 · Tarea Caso B (Compras · SwiftUI + SwiftData)

Alumno: Alexander Sanabria · Rama: `ia-asistida` · Herramienta: Claude (asistente de IA)

Cada consulta se registra con el formato pedido por el docente: **Contexto, Tarea, Restricciones, Formato esperado y qué hicimos con la respuesta**.

> Nota: la columna "Qué hicimos con la respuesta" debe revisarse antes de entregar. Si cambiaste algo del código sugerido, anótalo con el motivo.

---

## 1. Expediente técnico

- **Contexto:** Enunciado del Lab 11 (GLAB-S11-JLEONS), sección VIII, Grupo B · Caso Compras, y plantilla del anexo.
- **Tarea:** Redactar el expediente con sus 9 secciones: integrantes, modelo de datos con diagrama, matriz de permisos, reglas con ejemplos numéricos, 9 pantallas, casos de prueba, plan de commits, plan de IA y visto bueno.
- **Restricciones:** Usar solo las clases, reglas y casos del enunciado. Agregar 2 casos de prueba propios. Montos en soles.
- **Formato esperado:** Documento exportable a PDF.
- **Qué hicimos con la respuesta:** La revisamos y verificamos los cálculos a mano (1,416.00; 112.00; 115.56; 7,080.00). Se exportó como `Expediente_CasoB.pdf` y se subió a `main`.

## 2. Modelo de datos

- **Contexto:** Sección 2 del expediente.
- **Tarea:** Escribir las 4 clases `@Model` (Usuario, Proveedor, Producto, Compra) con sus relaciones.
- **Restricciones:** Relaciones uno a muchos con inversa y `deleteRule: .deny`. Compra calcula IGV (18 %), total, estado (≥ 5,000 → Pendiente), pagada y vence (crédito 30 días).
- **Formato esperado:** Un archivo Swift por clase, más `Sesion.swift` (`@Observable`) y la App con `.modelContainer`.
- **Qué hicimos con la respuesta:** Aceptada. Al principio pegamos el código de ContentView en el archivo de la App y salió *"Invalid redeclaration of 'ContentView'"*. Lo corregimos poniendo cada código en su archivo y borrando `Item.swift` de la plantilla.

## 3. Login y registro (B1, B2)

- **Contexto:** Reglas R8 y pantallas B1 y B2 del expediente.
- **Tarea:** Crear `LoginView` y `RegistroView`.
- **Restricciones:** Usuario único sin distinguir mayúsculas (`FetchDescriptor` + `#Predicate` + `fetchCount`). Clave de mínimo 6 caracteres igual a su confirmación. Mensaje genérico "Usuario o clave incorrectos". Al registrarse entra directo.
- **Formato esperado:** Vistas SwiftUI completas.
- **Qué hicimos con la respuesta:** Aceptada. Decisión: guardar el usuario en minúsculas para que el `#Predicate` compare por igualdad.

## 4. Pestañas por rol y componentes

- **Contexto:** Sección 3 (roles y permisos) del expediente.
- **Tarea:** `ContentView` con login o `TabView` según el rol, avatar con menú Cerrar sesión, insignias y fila de compra reutilizable.
- **Restricciones:** Comprador: Productos, Proveedores, Compra, Mis compras. Supervisor: Resumen, Aprobar, Por pagar, Productos, Proveedores. Cerrar sesión = `sesion.usuario = nil`.
- **Formato esperado:** `ContentView.swift`, `Componentes.swift` y `Utilidades.swift` (formato S/ y reglas R1–R3).
- **Qué hicimos con la respuesta:** Aceptada.

## 5. Productos y proveedores (B3, B4)

- **Contexto:** Pantallas B3 y B4 y regla R7.
- **Tarea:** Listas con búsqueda, CRUD solo para supervisor y borrado bloqueado si hay compras.
- **Restricciones:** Stock en color (verde > 10, ámbar 6–10, rojo ≤ 5), valor del inventario, insignia "por pagar" / "Al día", RUC de 11 dígitos.
- **Formato esperado:** `ProductosView.swift` y `ProveedoresView.swift` con sus formularios.
- **Qué hicimos con la respuesta:** Aceptada.

## 6. Nueva compra y mis compras (B5, B6)

- **Contexto:** Reglas R1, R2 y R4, y pantallas B5 y B6.
- **Tarea:** Formulario de compra con resumen en vivo, aviso desde S/ 5,000 y lista de compras propias.
- **Restricciones:** El botón dice "Enviar a aprobación" si el total es ≥ 5,000. Una compra aprobada aplica el costo promedio y suma stock. El comprador solo ve sus compras, con el segmented Todas / Pendientes / Rechazadas y búsqueda por proveedor.
- **Formato esperado:** `NuevaCompraView.swift` y `MisComprasView.swift`.
- **Qué hicimos con la respuesta:** Aceptada. Se agregó un selector de fecha para poder probar el caso 8 (compra vencida).

## 7. Aprobar, por pagar y resumen (B7, B8, B9)

- **Contexto:** Reglas R2, R3, R5 y R6, y pantallas B7, B8 y B9.
- **Tarea:** Tarjetas de aprobación con vista previa del efecto, rechazo con motivo obligatorio, cuentas por pagar con VENCIDA y Pagar, y resumen con gráfico.
- **Restricciones:** `@Query` con `#Predicate` para pendientes y créditos. El rechazo no cambia el stock. Pagar solo el supervisor. Barras por proveedor con Swift Charts.
- **Formato esperado:** `AprobarView.swift`, `PorPagarView.swift` y `ResumenView.swift`.
- **Qué hicimos con la respuesta:** Aceptada. Al compilar faltaba crear `ResumenView` (*"Cannot find 'ResumenView' in scope"*). Se creó y quedó con 0 errores.

## 8. Plan de pruebas

- **Contexto:** Sección 6 del expediente (11 casos).
- **Tarea:** Datos exactos para reproducir cada caso en el simulador.
- **Restricciones:** Un producto distinto por caso para que los números coincidan con los calculados a mano.
- **Formato esperado:** Lista de pasos con el resultado esperado.
- **Qué hicimos con la respuesta:** Ejecutamos los casos y tomamos capturas como evidencia. *(Completar: casos que pasaron o fallaron.)*

## 9. Ícono de la app

- **Contexto:** Requisito "Ícono de la app" del enunciado.
- **Tarea:** Ícono de 1024 × 1024 px.
- **Restricciones:** PNG cuadrado, sin transparencia y sin esquinas redondeadas.
- **Formato esperado:** `AppIcon_Compras_1024.png`.
- **Qué hicimos con la respuesta:** Se colocó en `Assets ▸ AppIcon`, con Display Name "Compras".
