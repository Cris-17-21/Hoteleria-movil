import 'package:flutter/material.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../general/tema/estilos_texto.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../rutas/nombres_rutas.dart';

class PaginaCheckInOut extends StatelessWidget {
  const PaginaCheckInOut({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutPrincipal(
      tituloBarra: 'Recepción / Check-in & Out',
      rutaActual: NombresRutas.checkInOut,
      cuerpo: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabecera
            Row(
              children: [
                const Icon(
                  Icons.assignment_turned_in_outlined,
                  color: HotelPMSColors.naranjaAcento,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text(
                  'Check-in / Out',
                  style: HotelPMSTextStyles.tituloDashboard,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Gestiona entradas y salidas',
              style: HotelPMSTextStyles.subtituloGris,
            ),
            const SizedBox(height: 20),

            // 2. Botón de Check-in
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ModalNuevoCheckIn(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: HotelPMSColors.naranjaAcento,
                  foregroundColor: HotelPMSColors.textoPrincipal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.login),
                label: const Text(
                  'Check-in',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Buscador
            Container(
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                style: TextStyle(color: HotelPMSColors.textoPrincipal),
                decoration: InputDecoration(
                  hintText: 'Buscar por cliente o reserva...',
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
            const SizedBox(height: 20),

            // 4. Lista de Movimientos (Adaptado a móvil)
            Expanded(
              child: ListView(
                children: [
                  _construirTarjetaMovimiento(
                    'RES-001',
                    'Juan Pérez',
                    '101',
                    '2026-05-02 14:30',
                    '-',
                    '2',
                    'Check-in',
                    true,
                  ),
                  const SizedBox(height: 12),
                  _construirTarjetaMovimiento(
                    'RES-002',
                    'María García',
                    '205',
                    '2026-05-01 15:00',
                    '2026-05-02 11:00',
                    '3',
                    'Completado',
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

  Widget _construirTarjetaMovimiento(
    String reserva,
    String cliente,
    String habitacion,
    String checkIn,
    String checkOut,
    String huespedes,
    String estado,
    bool requiereCheckOut,
  ) {
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
              Text(
                'Reserva: $reserva',
                style: HotelPMSTextStyles.subtituloGris,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: requiereCheckOut
                      ? Colors.transparent
                      : HotelPMSColors.textoSecundario.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: requiereCheckOut
                        ? HotelPMSColors.textoPrincipal
                        : HotelPMSColors.textoSecundario,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(cliente, style: HotelPMSTextStyles.tituloTarjeta),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _columnaDato('Habitación', habitacion),
              _columnaDato('Huéspedes', huespedes),
            ],
          ),
          const SizedBox(height: 12),
          _filaDetalle('Check-in:', checkIn),
          const SizedBox(height: 4),
          _filaDetalle('Check-out:', checkOut),
          const SizedBox(height: 16),
          if (requiereCheckOut)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: HotelPMSColors.textoEliminar,
                  side: const BorderSide(color: HotelPMSColors.textoEliminar),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.logout),
                label: const Text(
                  'Check-out',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _columnaDato(String etiqueta, String valor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          etiqueta,
          style: HotelPMSTextStyles.subtituloGris.copyWith(fontSize: 11),
        ),
        Text(
          valor,
          style: const TextStyle(
            color: HotelPMSColors.textoPrincipal,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _filaDetalle(String etiqueta, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(etiqueta, style: HotelPMSTextStyles.subtituloGris),
        Text(
          valor,
          style: TextStyle(
            color: valor == '-'
                ? HotelPMSColors.textoSecundario
                : HotelPMSColors.textoPrincipal,
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// MODAL DE CHECK-IN
// =========================================================================
class ModalNuevoCheckIn extends StatefulWidget {
  const ModalNuevoCheckIn({super.key});

  @override
  State<ModalNuevoCheckIn> createState() => _ModalNuevoCheckInState();
}

class _ModalNuevoCheckInState extends State<ModalNuevoCheckIn> {
  String reservaSeleccionada = 'RES-003 - Carlos López - Hab. 304';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nuevo Check-in',
              style: TextStyle(
                color: HotelPMSColors.textoPrincipal,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Selector de Reserva
            const Text(
              'Reserva',
              style: TextStyle(
                color: HotelPMSColors.textoPrincipal,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: reservaSeleccionada,
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
                  onChanged: (String? nuevoValor) {
                    if (nuevoValor != null) {
                      setState(() => reservaSeleccionada = nuevoValor);
                    }
                  },
                  items:
                      [
                        'RES-003 - Carlos López - Hab. 304',
                        'RES-004 - Ana Martínez - Hab. 202',
                      ].map((String valor) {
                        return DropdownMenuItem<String>(
                          value: valor,
                          child: Text(valor),
                        );
                      }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Fecha y Hora
            const Text(
              'Fecha y Hora de Ingreso',
              style: TextStyle(
                color: HotelPMSColors.textoPrincipal,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoInput,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                readOnly: true,
                style: const TextStyle(color: HotelPMSColors.textoPrincipal),
                decoration: InputDecoration(
                  hintText: 'dd/mm/aaaa --:--',
                  hintStyle: HotelPMSTextStyles.subtituloGris,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: HotelPMSColors.textoSecundario,
                    size: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Huéspedes
            Row(
              children: [
                const Icon(
                  Icons.person_add_alt_1_outlined,
                  color: HotelPMSColors.textoSecundario,
                  size: 16,
                ),
                const SizedBox(width: 6),
                const Text(
                  'Huéspedes Registrados',
                  style: TextStyle(
                    color: HotelPMSColors.textoPrincipal,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: HotelPMSColors.fondoOscuro,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Carlos López (DNI: 12345678)',
                      style: TextStyle(
                        color: HotelPMSColors.textoPrincipal,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Eliminar',
                      style: TextStyle(
                        color: HotelPMSColors.textoEliminar,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: HotelPMSColors.textoPrincipal,
                  side: const BorderSide(color: Colors.white24),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('+ Agregar Huésped'),
              ),
            ),
            const SizedBox(height: 24),

            // Botones Finales
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HotelPMSColors.fondoInput,
                      foregroundColor: HotelPMSColors.textoPrincipal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HotelPMSColors.naranjaAcento,
                      foregroundColor: HotelPMSColors.textoPrincipal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Confirmar Check-in',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
