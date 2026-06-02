import 'package:flutter/material.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../general/tema/estilos_texto.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../rutas/nombres_rutas.dart';

class PaginaHabitaciones extends StatefulWidget {
  const PaginaHabitaciones({super.key});

  @override
  State<PaginaHabitaciones> createState() => _PaginaHabitacionesState();
}

class _PaginaHabitacionesState extends State<PaginaHabitaciones> {
  String pisoSeleccionado = 'Todos los pisos';
  String estadoSeleccionado = 'Todos los estados';

  @override
  Widget build(BuildContext context) {
    return LayoutPrincipal(
      tituloBarra: 'Recepción / Habitaciones',
      rutaActual: NombresRutas.habitaciones,
      cuerpo: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabecera
            Row(
              children: [
                const Icon(
                  Icons.domain,
                  color: HotelPMSColors.naranjaAcento,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text('Habitaciones', style: HotelPMSTextStyles.tituloDashboard),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Administra el estado y disponibilidad',
              style: HotelPMSTextStyles.subtituloGris,
            ),
            const SizedBox(height: 20),

            // 2. Botón "+ Nueva"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _mostrarModalNuevaHabitacion(
                  context,
                ), // Abre la ventana emergente
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
                  'Nueva',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Filtros y Búsqueda
            Container(
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                style: TextStyle(color: HotelPMSColors.textoPrincipal),
                decoration: InputDecoration(
                  hintText: 'Buscar habitación...',
                  hintStyle: HotelPMSTextStyles.subtituloGris,
                  prefixIcon: Icon(
                    Icons.search,
                    color: HotelPMSColors.textoSecundario,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Dropdowns de Filtros
            _construirDropdown(
              valorActual: pisoSeleccionado,
              opciones: ['Todos los pisos', 'Piso 1', 'Piso 2', 'Piso 3'],
              alCambiar: (nuevoValor) =>
                  setState(() => pisoSeleccionado = nuevoValor!),
            ),
            const SizedBox(height: 12),
            _construirDropdown(
              valorActual: estadoSeleccionado,
              opciones: [
                'Todos los estados',
                'Disponible',
                'Reservada',
                'Limpieza',
                'Ocupada',
              ],
              alCambiar: (nuevoValor) =>
                  setState(() => estadoSeleccionado = nuevoValor!),
            ),

            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(
                  Icons.filter_alt_outlined,
                  color: HotelPMSColors.textoSecundario,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Mostrando 12 de 12',
                  style: HotelPMSTextStyles.subtituloGris,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 4. Cuadrícula de Habitaciones
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.68, // Ajusta la altura de las tarjetas
                children: [
                  _construirTarjetaHabitacion(
                    '101',
                    'Simple',
                    'Piso 1',
                    'Disponible',
                    'S/ 80/noche',
                    false,
                  ),
                  _construirTarjetaHabitacion(
                    '102',
                    'Doble',
                    'Piso 1',
                    'Ocupada',
                    'S/ 120/noche',
                    true,
                  ),
                  _construirTarjetaHabitacion(
                    '103',
                    'Suite',
                    'Piso 1',
                    'Reservada',
                    'S/ 200/noche',
                    false,
                  ),
                  _construirTarjetaHabitacion(
                    '104',
                    'Matrimonial',
                    'Piso 1',
                    'Limpieza',
                    'S/ 150/noche',
                    false,
                  ),
                  _construirTarjetaHabitacion(
                    '201',
                    'Simple',
                    'Piso 2',
                    'Disponible',
                    'S/ 80/noche',
                    false,
                  ),
                  _construirTarjetaHabitacion(
                    '202',
                    'Doble',
                    'Piso 2',
                    'Disponible',
                    'S/ 120/noche',
                    false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Molde para los menús desplegables
  Widget _construirDropdown({
    required String valorActual,
    required List<String> opciones,
    required void Function(String?) alCambiar,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoTarjeta,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: valorActual,
          isExpanded: true,
          dropdownColor: HotelPMSColors.fondoInput,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: HotelPMSColors.textoPrincipal,
          ),
          style: const TextStyle(
            color: HotelPMSColors.textoPrincipal,
            fontSize: 14,
          ),
          onChanged: alCambiar,
          items: opciones.map((String valor) {
            return DropdownMenuItem<String>(value: valor, child: Text(valor));
          }).toList(),
        ),
      ),
    );
  }

  // Molde para las tarjetas de habitación
  Widget _construirTarjetaHabitacion(
    String numero,
    String tipo,
    String piso,
    String estado,
    String precio,
    bool esOcupada,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoTarjeta,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: esOcupada ? HotelPMSColors.azulAcento : Colors.white10,
          width: esOcupada ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.edit_outlined,
                color: HotelPMSColors.textoSecundario,
                size: 18,
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.delete_outline,
                color: HotelPMSColors.textoEliminar,
                size: 18,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: esOcupada
                  ? HotelPMSColors.azulAcento.withValues(alpha: 0.2)
                  : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.domain,
              color: esOcupada
                  ? HotelPMSColors.azulAcento
                  : HotelPMSColors.textoPrincipal,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(numero, style: HotelPMSTextStyles.valorGrande),
          Text(
            tipo,
            style: HotelPMSTextStyles.subtituloGris.copyWith(fontSize: 12),
          ),
          Text(
            piso,
            style: HotelPMSTextStyles.subtituloGris.copyWith(fontSize: 12),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: esOcupada
                  ? HotelPMSColors.azulAcento.withValues(alpha: 0.2)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              estado,
              style: TextStyle(
                color: esOcupada
                    ? HotelPMSColors.azulAcento
                    : HotelPMSColors.textoPrincipal,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(precio, style: HotelPMSTextStyles.precioDestacado),
        ],
      ),
    );
  }

  // Función para mostrar el modal de "Nueva Habitación"
  void _mostrarModalNuevaHabitacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: HotelPMSColors.fondoTarjeta,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Nueva Habitación',
            style: TextStyle(
              color: HotelPMSColors.textoPrincipal,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _crearCampoModal('Número', 'Ej: 101'),
                const SizedBox(height: 12),
                const Text(
                  'Tipo',
                  style: TextStyle(
                    color: HotelPMSColors.textoPrincipal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                _construirDropdown(
                  valorActual: 'Simple',
                  opciones: ['Simple', 'Doble', 'Suite', 'Matrimonial'],
                  alCambiar: (v) {}, // Mock visual
                ),
                const SizedBox(height: 12),
                _crearCampoModal('Piso', 'Ej: 1'),
                const SizedBox(height: 12),
                _crearCampoModal('Precio por noche (S/)', 'Ej: 80'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: HotelPMSColors.textoPrincipal),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: HotelPMSColors.naranjaAcento,
                foregroundColor: HotelPMSColors.textoPrincipal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Widget _crearCampoModal(String etiqueta, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: const TextStyle(
            color: HotelPMSColors.textoPrincipal,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: HotelPMSColors.fondoInput,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            style: const TextStyle(color: HotelPMSColors.textoPrincipal),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: HotelPMSTextStyles.subtituloGris,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
