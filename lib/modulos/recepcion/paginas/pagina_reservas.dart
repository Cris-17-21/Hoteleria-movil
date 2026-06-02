import 'package:flutter/material.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../general/tema/estilos_texto.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../rutas/nombres_rutas.dart';

class PaginaReservas extends StatelessWidget {
  const PaginaReservas({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutPrincipal(
      tituloBarra: 'Recepción / Reservas',
      rutaActual: NombresRutas.reservas,
      cuerpo: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Cabecera
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: HotelPMSColors.naranjaAcento,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Text('Reservas', style: HotelPMSTextStyles.tituloDashboard),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Administra reservas de habitaciones',
              style: HotelPMSTextStyles.subtituloGris,
            ),
            const SizedBox(height: 20),

            // 2. Botón "+ Nueva Reserva"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const ModalNuevaReserva(),
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
                icon: const Icon(Icons.add),
                label: const Text(
                  'Nueva Reserva',
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
                  hintText: 'Buscar por cliente o habitación...',
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

            // 4. Lista de Reservas
            Expanded(
              child: ListView(
                children: [
                  _construirTarjetaReserva(
                    '#1',
                    'Juan Pérez',
                    'Check-in',
                    '2026-05-02',
                    '2026-05-05',
                    '101, 102',
                    '4',
                    'S/ 600',
                    HotelPMSColors.textoPrincipal,
                  ),
                  const SizedBox(height: 12),
                  _construirTarjetaReserva(
                    '#2',
                    'María García',
                    'Pagada',
                    '2026-05-03',
                    '2026-05-06',
                    '205',
                    '2',
                    'S/ 360',
                    HotelPMSColors.azulAcento,
                  ),
                  const SizedBox(height: 12),
                  _construirTarjetaReserva(
                    '#3',
                    'Carlos López',
                    'Pendiente',
                    '2026-05-04',
                    '2026-05-07',
                    '304',
                    '2',
                    'S/ 450',
                    HotelPMSColors.textoSecundario,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirTarjetaReserva(
    String id,
    String nombre,
    String estado,
    String checkIn,
    String checkOut,
    String habs,
    String huespedes,
    String total,
    Color colorEstado,
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
              Text(id, style: HotelPMSTextStyles.subtituloGris),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: colorEstado == HotelPMSColors.textoPrincipal
                      ? Colors.transparent
                      : colorEstado.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  estado,
                  style: TextStyle(
                    color: colorEstado,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(nombre, style: HotelPMSTextStyles.tituloTarjeta),
          const SizedBox(height: 16),
          _filaDetalle('Check-in:', checkIn),
          const SizedBox(height: 8),
          _filaDetalle('Check-out:', checkOut),
          const SizedBox(height: 8),
          _filaDetalle('Habitaciones:', habs),
          const SizedBox(height: 8),
          _filaDetalle('Huéspedes:', huespedes),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: HotelPMSTextStyles.subtituloGris),
              Text(
                total,
                style: HotelPMSTextStyles.precioDestacado.copyWith(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: HotelPMSColors.fondoInput,
                foregroundColor: HotelPMSColors.textoPrincipal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ver Detalles'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filaDetalle(String etiqueta, String valor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(etiqueta, style: HotelPMSTextStyles.subtituloGris),
        Text(
          valor,
          style: const TextStyle(
            color: HotelPMSColors.textoPrincipal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// WIDGET DEL MODAL (Controla los pasos internamente)
// =========================================================================
class ModalNuevaReserva extends StatefulWidget {
  const ModalNuevaReserva({super.key});

  @override
  State<ModalNuevaReserva> createState() => _ModalNuevaReservaState();
}

class _ModalNuevaReservaState extends State<ModalNuevaReserva> {
  int pasoActual = 0; // 0: Cliente, 1: Fechas, 2: Habitaciones
  int cantSimple = 0;
  int cantDoble = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Nueva Reserva',
              style: TextStyle(
                color: HotelPMSColors.textoPrincipal,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Barra de progreso de pasos
            Row(
              children: [
                _indicadorPaso('Cliente', 0),
                const SizedBox(width: 8),
                _indicadorPaso('Fechas', 1),
                const SizedBox(width: 8),
                _indicadorPaso('Habitaciones', 2),
              ],
            ),
            const SizedBox(height: 24),

            // Contenido dinámico según el paso
            Expanded(
              child: SingleChildScrollView(child: _construirPasoActual()),
            ),

            const SizedBox(height: 16),

            // Botones de navegación
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (pasoActual > 0)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => pasoActual--),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HotelPMSColors.fondoInput,
                        foregroundColor: HotelPMSColors.textoPrincipal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Anterior'),
                    ),
                  )
                else
                  const Spacer(),

                const SizedBox(width: 12),

                if (pasoActual < 2)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => setState(() => pasoActual++),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HotelPMSColors.naranjaAcento,
                        foregroundColor: HotelPMSColors.textoPrincipal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Siguiente'),
                    ),
                  )
                else
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: HotelPMSColors.naranjaAcento,
                        foregroundColor: HotelPMSColors.textoPrincipal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Confirmar Reserva'),
                    ),
                  ),

                if (pasoActual == 0) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancelar',
                        style: TextStyle(color: HotelPMSColors.textoEliminar),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _indicadorPaso(String titulo, int indice) {
    bool activo = pasoActual >= indice;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: activo
                  ? HotelPMSColors.naranjaAcento
                  : HotelPMSColors.fondoInput,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            titulo,
            style: TextStyle(
              color: activo
                  ? HotelPMSColors.textoPrincipal
                  : HotelPMSColors.textoSecundario,
              fontSize: 10,
              fontWeight: activo ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _construirPasoActual() {
    if (pasoActual == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _campoTexto(
            'DNI/RUC del Cliente',
            'Ej: 12345678',
            Icons.person_outline,
          ),
          const SizedBox(height: 16),
          _campoTexto('Nombre Completo', 'Ej: Juan Pérez', null),
          const SizedBox(height: 16),
          _campoTexto(
            'Comentarios',
            'Observaciones adicionales...',
            null,
            maxLines: 3,
          ),
        ],
      );
    } else if (pasoActual == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _campoTexto(
            'Fecha de Check-in',
            'dd/mm/aaaa',
            Icons.calendar_today,
            soloLectura: true,
          ),
          const SizedBox(height: 16),
          _campoTexto(
            'Fecha de Check-out',
            'dd/mm/aaaa',
            Icons.calendar_today,
            soloLectura: true,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _contadorHabitacion(
            'Simple',
            'S/ 80/noche',
            3,
            cantSimple,
            (v) => setState(() => cantSimple = v),
          ),
          const SizedBox(height: 12),
          _contadorHabitacion(
            'Doble',
            'S/ 120/noche',
            2,
            cantDoble,
            (v) => setState(() => cantDoble = v),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: HotelPMSColors.naranjaAcento),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Estimado:',
                  style: TextStyle(
                    color: HotelPMSColors.textoPrincipal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'S/ ${(cantSimple * 80) + (cantDoble * 120)}',
                  style: const TextStyle(
                    color: HotelPMSColors.naranjaAcento,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _campoTexto(
    String etiqueta,
    String hint,
    IconData? icono, {
    int maxLines = 1,
    bool soloLectura = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icono != null) ...[
              Icon(icono, color: HotelPMSColors.textoPrincipal, size: 16),
              const SizedBox(width: 4),
            ],
            Text(
              etiqueta,
              style: const TextStyle(
                color: HotelPMSColors.textoPrincipal,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: HotelPMSColors.fondoInput,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            readOnly: soloLectura,
            maxLines: maxLines,
            style: const TextStyle(color: HotelPMSColors.textoPrincipal),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: HotelPMSTextStyles.subtituloGris,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              suffixIcon: soloLectura
                  ? const Icon(
                      Icons.calendar_today,
                      color: HotelPMSColors.textoSecundario,
                      size: 18,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _contadorHabitacion(
    String tipo,
    String precio,
    int disponibles,
    int cantidad,
    ValueChanged<int> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoInput,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: HotelPMSColors.fondoOscuro,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.domain,
              color: HotelPMSColors.naranjaAcento,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tipo,
                  style: const TextStyle(
                    color: HotelPMSColors.textoPrincipal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$precio • Disponible: $disponibles',
                  style: const TextStyle(
                    color: HotelPMSColors.textoSecundario,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: HotelPMSColors.textoPrincipal,
                  size: 16,
                ),
                onPressed: cantidad > 0 ? () => onChanged(cantidad - 1) : null,
              ),
              Text(
                '$cantidad',
                style: const TextStyle(
                  color: HotelPMSColors.textoPrincipal,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: HotelPMSColors.naranjaAcento,
                  size: 16,
                ),
                onPressed: cantidad < disponibles
                    ? () => onChanged(cantidad + 1)
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
