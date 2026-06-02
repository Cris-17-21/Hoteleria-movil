import 'package:flutter/material.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../general/tema/estilos_texto.dart';
import '../../../general/layout/layout_principal.dart'; // 1. Importamos el layout de tu grupo
import '../../../rutas/nombres_rutas.dart'; // 2. Importamos las rutas

class PaginaUsuarios extends StatelessWidget {
  const PaginaUsuarios({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Usamos LayoutPrincipal en lugar de Scaffold para no perder el menú lateral
    return LayoutPrincipal(
      tituloBarra:
          'Seguridad / Usuarios', // Título que saldrá en la parte superior
      rutaActual: NombresRutas
          .usuarios, // Le avisa al menú para que se pinte de naranja
      cuerpo: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabecera con Icono, Título y Subtítulo
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  color: HotelPMSColors.naranjaAcento,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text('Usuarios', style: HotelPMSTextStyles.tituloDashboard),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Administra los usuarios del sistema',
              style: HotelPMSTextStyles.subtituloGris,
            ),
            const SizedBox(height: 20),

            // 2. Botón "+ Nuevo"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {}, // Aún no hace nada
                style: ElevatedButton.styleFrom(
                  backgroundColor: HotelPMSColors.naranjaAcento,
                  foregroundColor: HotelPMSColors.textoPrincipal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.add),
                label: const Text(
                  'Nuevo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Barra de Búsqueda
            Container(
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                style: const TextStyle(color: HotelPMSColors.textoPrincipal),
                decoration: InputDecoration(
                  hintText: 'Buscar usuarios...',
                  hintStyle: HotelPMSTextStyles.subtituloGris,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: HotelPMSColors.textoSecundario,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 4. Lista de Usuarios (Tarjetas)
            Expanded(
              child: ListView(
                children: [
                  _construirTarjetaUsuario(
                    numero: '#1',
                    nombre: 'Admin User',
                    correo: 'admin@hotel.com',
                    rol: 'Administrador',
                    activo: true,
                  ),
                  const SizedBox(height: 12),
                  _construirTarjetaUsuario(
                    numero: '#2',
                    nombre: 'María Recepción',
                    correo: 'maria@hotel.com',
                    rol: 'Recepcionista',
                    activo: true,
                  ),
                  const SizedBox(height: 12),
                  _construirTarjetaUsuario(
                    numero: '#3',
                    nombre: 'Juan Ventas',
                    correo: 'juan@hotel.com',
                    rol: 'Vendedor',
                    activo: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // "Molde" para crear cada tarjeta de usuario
  Widget _construirTarjetaUsuario({
    required String numero,
    required String nombre,
    required String correo,
    required String rol,
    required bool activo,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoTarjeta,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(numero, style: HotelPMSTextStyles.subtituloGris),
              Text('Activo', style: HotelPMSTextStyles.estadoBadge),
            ],
          ),
          const SizedBox(height: 4),
          Text(nombre, style: HotelPMSTextStyles.tituloTarjeta),
          const SizedBox(height: 2),
          Text(correo, style: HotelPMSTextStyles.subtituloGris),
          const SizedBox(height: 12),
          const Divider(color: Colors.white10, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(rol, style: HotelPMSTextStyles.textoRolNaranja),
              Row(
                children: [
                  _botonAccion(
                    Icons.edit_outlined,
                    HotelPMSColors.textoSecundario,
                  ),
                  const SizedBox(width: 8),
                  _botonAccion(
                    Icons.delete_outline,
                    HotelPMSColors.textoEliminar,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Pequeños botones de editar y eliminar
  Widget _botonAccion(IconData icono, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.1,
        ), // <-- Solución para la versión nueva de Flutter
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icono, color: color, size: 20),
    );
  }
}
