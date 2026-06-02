import 'package:flutter/material.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../general/tema/colores_tema.dart';

class PaginaMantenimiento extends StatefulWidget {
  const PaginaMantenimiento({super.key});

  @override
  State<PaginaMantenimiento> createState() => _PaginaMantenimientoState();
}

class _PaginaMantenimientoState extends State<PaginaMantenimiento> {
  String tipoFiltro = 'Todos los tipos';
  String estadoFiltro = 'Todos los estados';

  // Datos mock para las tareas de mantenimiento
  final List<Map<String, dynamic>> tareas = [
    {
      'tipo': 'Limpieza',
      'estado': 'Completado',
      'titulo': 'Habitación 101',
      'descripcion': 'Limpieza post check-out',
      'responsable': 'María López',
      'fecha': '2026-05-02',
    },
    {
      'tipo': 'Incidencia',
      'estado': 'En Proceso',
      'titulo': 'Habitación 205',
      'descripcion': 'Aire acondicionado no funciona',
      'responsable': 'Carlos Técnico',
      'fecha': '2026-05-02',
    },
    {
      'tipo': 'Limpieza',
      'estado': 'Pendiente',
      'titulo': 'Salón Principal',
      'descripcion': 'Limpieza diaria',
      'responsable': 'Ana García',
      'fecha': '2026-05-02',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Filtrar tareas (simulación básica)
    final tareasFiltradas = tareas.where((t) {
      bool matchTipo = tipoFiltro == 'Todos los tipos' || t['tipo'] == tipoFiltro;
      bool matchEstado = estadoFiltro == 'Todos los estados' || t['estado'] == estadoFiltro;
      return matchTipo && matchEstado;
    }).toList();

    // Contadores
    final pendientes = tareas.where((t) => t['estado'] == 'Pendiente').length;
    final enProceso = tareas.where((t) => t['estado'] == 'En Proceso').length;
    final completados = tareas.where((t) => t['estado'] == 'Completado').length;

    return LayoutPrincipal(
      rutaActual: '/mantenimiento',
      tituloBarra: 'HotelPMS',
      cuerpo: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título y Subtítulo
              Row(
                children: [
                  const Icon(
                    Icons.construction,
                    color: HotelPMSColors.naranjaAcento,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Mantenimiento',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: HotelPMSColors.textoPrincipal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Limpieza e incidencias',
                style: TextStyle(
                  fontSize: 13,
                  color: HotelPMSColors.textoSecundario,
                ),
              ),
              const SizedBox(height: 16),

              // Tarjetas de Resumen (Pendientes, En Proceso, Completados)
              _buildResumenCard('Pendientes', pendientes.toString(), Icons.error_outline),
              const SizedBox(height: 10),
              _buildResumenCard('En Proceso', enProceso.toString(), Icons.construction_outlined),
              const SizedBox(height: 10),
              _buildResumenCard('Completados Hoy', completados.toString(), Icons.check_circle_outlined),
              const SizedBox(height: 16),

              // Selectores de Filtro
              _buildDropdownFiltro(
                valorActual: tipoFiltro,
                opciones: ['Todos los tipos', 'Limpieza', 'Incidencia'],
                onChanged: (val) {
                  if (val != null) setState(() => tipoFiltro = val);
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownFiltro(
                valorActual: estadoFiltro,
                opciones: ['Todos los estados', 'Pendiente', 'En Proceso', 'Completado'],
                onChanged: (val) {
                  if (val != null) setState(() => estadoFiltro = val);
                },
              ),
              const SizedBox(height: 16),

              // Listado de Tareas
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tareasFiltradas.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final tarea = tareasFiltradas[index];
                  return _buildTarjetaTarea(tarea);
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Tarjetas de Resumen
  Widget _buildResumenCard(String titulo, String valor, IconData icono) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoTarjeta,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HotelPMSColors.fondoInput.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  color: HotelPMSColors.textoSecundario,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                valor,
                style: const TextStyle(
                  color: Colors.blueAccent, // Color azul para el contador
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            icono,
            color: HotelPMSColors.textoSecundario,
            size: 20,
          ),
        ],
      ),
    );
  }

  // Dropdown Filtro personalizado estilo Noir
  Widget _buildDropdownFiltro({
    required String valorActual,
    required List<String> opciones,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoInput,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: valorActual,
          dropdownColor: HotelPMSColors.fondoInput,
          icon: const Icon(Icons.keyboard_arrow_down, color: HotelPMSColors.textoSecundario),
          style: const TextStyle(
            color: HotelPMSColors.textoPrincipal,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: opciones.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // Tarjeta de Tarea Individual (Habitaciones / Salones)
  Widget _buildTarjetaTarea(Map<String, dynamic> tarea) {
    final String tipo = tarea['tipo'];
    final String estado = tarea['estado'];

    // Configuración de colores para los Badges
    Color tipoFondo = Colors.blue.withOpacity(0.15);
    Color tipoTexto = Colors.blueAccent;
    if (tipo == 'Incidencia') {
      tipoFondo = const Color(0xFF7F1D1D).withOpacity(0.3);
      tipoTexto = const Color(0xFFEF4444);
    }

    Color estadoFondo = const Color(0xFF27272A);
    Color estadoTexto = const Color(0xFFD4D4D8);
    if (estado == 'En Proceso') {
      estadoFondo = Colors.blue.withOpacity(0.15);
      estadoTexto = Colors.blueAccent;
    } else if (estado == 'Completado') {
      estadoFondo = const Color(0xFF27272A);
      estadoTexto = Colors.white;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: HotelPMSColors.fondoTarjeta,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HotelPMSColors.fondoInput.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Badges + Botón Actualizar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Badge Tipo
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: tipoFondo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      tipo,
                      style: TextStyle(
                        color: tipoTexto,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Badge Estado
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: estadoFondo,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      estado,
                      style: TextStyle(
                        color: estadoTexto,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // Botón Actualizar
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: HotelPMSColors.naranjaAcento,
                    foregroundColor: HotelPMSColors.textoPrincipal,
                    minimumSize: Size.zero, // Sobrescribir el ancho infinito del tema global
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                  onPressed: () {
                    _mostrarDialogoActualizar(tarea);
                  },
                  child: const Text(
                    'Actualizar',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Título
          Text(
            tarea['titulo'],
            style: const TextStyle(
              color: HotelPMSColors.textoPrincipal,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Descripción
          Text(
            tarea['descripcion'],
            style: const TextStyle(
              color: HotelPMSColors.textoSecundario,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),

          // Footer (Responsable y Fecha)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Responsable:',
                      style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      tarea['responsable'],
                      style: const TextStyle(
                        color: HotelPMSColors.textoPrincipal,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Fecha:',
                    style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    tarea['fecha'],
                    style: const TextStyle(
                      color: HotelPMSColors.textoPrincipal,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Diálogo simulado para el botón "Actualizar"
  void _mostrarDialogoActualizar(Map<String, dynamic> tarea) {
    showDialog(
      context: context,
      builder: (context) {
        String estadoTemporal = tarea['estado'];
        return AlertDialog(
          backgroundColor: HotelPMSColors.fondoTarjeta,
          title: Text(
            'Actualizar ${tarea['titulo']}',
            style: const TextStyle(color: HotelPMSColors.textoPrincipal),
          ),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Cambiar el estado de la tarea:',
                    style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13),
                  ),
                  const SizedBox(height: 16),
                  ...['Pendiente', 'En Proceso', 'Completado'].map((est) {
                    return RadioListTile<String>(
                      title: Text(est, style: const TextStyle(color: HotelPMSColors.textoPrincipal)),
                      value: est,
                      groupValue: estadoTemporal,
                      activeColor: HotelPMSColors.naranjaAcento,
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => estadoTemporal = val);
                        }
                      },
                    );
                  }),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: HotelPMSColors.textoSecundario)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: HotelPMSColors.naranjaAcento),
              onPressed: () {
                setState(() {
                  tarea['estado'] = estadoTemporal;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Estado de ${tarea['titulo']} actualizado a $estadoTemporal'),
                    backgroundColor: HotelPMSColors.fondoTarjeta,
                  ),
                );
              },
              child: const Text('Guardar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
