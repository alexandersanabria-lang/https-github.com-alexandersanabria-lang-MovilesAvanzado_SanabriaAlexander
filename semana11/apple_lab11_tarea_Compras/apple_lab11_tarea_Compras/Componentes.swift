import SwiftUI
import SwiftData

// Avatar con las iniciales del usuario y menú para cerrar sesión
struct AvatarMenu: View {
    @Environment(Sesion.self) private var sesion

    var body: some View {
        if let usuario = sesion.usuario {
            Menu {
                Section {
                    Label(usuario.nombre, systemImage: "person.fill")
                    Label(usuario.rol, systemImage: usuario.esSupervisor ? "star.fill" : "cart.fill")
                }
                Button(role: .destructive) {
                    sesion.usuario = nil          // vuelve solo al login
                } label: {
                    Label("Cerrar sesión", systemImage: "rectangle.portrait.and.arrow.right")
                }
            } label: {
                Text(usuario.iniciales)
                    .font(.caption.bold())
                    .foregroundStyle(.white)
                    .frame(width: 34, height: 34)
                    .background(Circle().fill(usuario.esSupervisor ? Color.orange : Color.indigo))
            }
        }
    }
}

// Etiqueta pequeña de color (estado, "Al día", "VENCIDA"...)
struct Insignia: View {
    let texto: String
    let color: Color

    var body: some View {
        Text(texto)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}

// Fila reutilizable para mostrar una compra
struct FilaCompra: View {
    let compra: Compra
    var mostrarComprador = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(compra.producto?.nombre ?? "Producto")
                    .font(.headline)
                Spacer()
                Text(compra.total.soles)
                    .font(.headline)
            }

            Text("\(compra.proveedor?.nombre ?? "Proveedor") · \(compra.cantidad) × \(compra.costoUnitario.soles)")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if mostrarComprador {
                Text("Solicitó: \(compra.comprador?.nombre ?? "—")")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 6) {
                Insignia(texto: compra.estado, color: compra.colorEstado)
                Insignia(texto: compra.alCredito ? "Crédito" : "Contado", color: .blue)
                if compra.estaVencida {
                    Insignia(texto: "VENCIDA", color: .red)
                } else if compra.alCredito && compra.estado == "Aprobada" {
                    if compra.pagada {
                        Insignia(texto: "Pagada", color: .green)
                    } else {
                        Insignia(texto: "Vence \(compra.vence.corta)", color: .gray)
                    }
                }
                Spacer()
                Text(compra.fecha.corta)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if compra.estado == "Rechazada", let motivo = compra.motivoRechazo {
                Text("Motivo: \(motivo)")
                    .font(.caption)
                    .foregroundStyle(.red)
            }
        }
        .padding(.vertical, 4)
    }
}
