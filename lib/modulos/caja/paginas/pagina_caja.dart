import 'package:flutter/material.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../rutas/nombres_rutas.dart';
import '../modelos/modelo_movimiento.dart';

class PaginaCaja extends StatefulWidget {
  const PaginaCaja({super.key});

  @override
  State<PaginaCaja> createState() => _PaginaCajaState();
}

class _PaginaCajaState extends State<PaginaCaja> {
  // Datos basados en tus capturas
  final double _montoInicial = 500.00;
  final double _totalIngresos = 1130.00;
  final double _totalEgresos = 120.00;
  double get _saldoSistema => _montoInicial + _totalIngresos - _totalEgresos; // S/ 1,510.00

  // Estado del arqueo y cierre
  double _totalContadoArqueo = 0.0;
  bool _arqueoRealizado = false;

  // Lista mutable para poder insertar dinámicamente nuevos movimientos
  final List<ModeloMovimiento> _movimientos = [
    const ModeloMovimiento(id: '1', tipo: 'Venta', descripcion: 'Venta #001 - Juan Pérez', fecha: '2026-05-02', hora: '09:30', monto: 350.00),
    const ModeloMovimiento(id: '2', tipo: 'Ingreso', descripcion: 'Depósito inicial', fecha: '2026-05-02', hora: '08:00', monto: 500.00),
    const ModeloMovimiento(id: '3', tipo: 'Egreso', descripcion: 'Compra de insumos', fecha: '2026-05-02', hora: '11:15', monto: -120.00),
    const ModeloMovimiento(id: '4', tipo: 'Venta', descripcion: 'Venta #002 - María García', fecha: '2026-05-02', hora: '14:20', monto: 280.00),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Envolvemos el cuerpo dentro de tu LayoutPrincipal nativo
      body: LayoutPrincipal(
        rutaActual: NombresRutas.caja,
        tituloBarra: 'HotelPMS',
        cuerpo: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Encabezado del Módulo
              Row(
                children: [
                  const Icon(Icons.account_balance_wallet_outlined, color: HotelPMSColors.naranjaAcento, size: 28),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Caja', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal)),
                      Text('Administra movimientos e ingresos', style: TextStyle(fontSize: 12, color: HotelPMSColors.textoSecundario)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Botones de Procesos de Auditoría (Arqueo y Cierre)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB), 
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.analytics_outlined, size: 18),
                      label: const Text('Arqueo', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => _mostrarArqueoModal(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFEF4444), 
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: const Icon(Icons.lock_outline, size: 18),
                      label: const Text('Cerrar', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => _mostrarCerrarCajaModal(context),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 3. Grid / Tarjetas de Resumen de Saldos
              _buildTarjetaMonto('Monto Inicial', 'S/ ${_montoInicial.toStringAsFixed(2)}', Colors.blue),
              const SizedBox(height: 12),
              _buildTarjetaMonto('Total Ingresos', 'S/ ${_totalIngresos.toStringAsFixed(2)}', Colors.green),
              const SizedBox(height: 12),
              _buildTarjetaMonto('Total Egresos', 'S/ ${_totalEgresos.toStringAsFixed(2)}', Colors.red),
              const SizedBox(height: 12),
              
              // Tarjeta Destacada: Saldo en Sistema
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: HotelPMSColors.fondoTarjeta,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: HotelPMSColors.naranjaAcento, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Saldo Actual', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13)),
                        const SizedBox(height: 6),
                        Text('S/ ${_saldoSistema.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.naranjaAcento, fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Icon(Icons.wallet, color: HotelPMSColors.naranjaAcento, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4. Sección de Historial con Cabeceras de Tabla
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Movimientos del Día (${_movimientos.length})', 
                    style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Cabeceras explícitas de la tabla (Alineadas con las filas inferiores)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: Text('TIPO', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                    Expanded(
                      flex: 4,
                      child: Text('DESCRIPCIÓN', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text('MONTO', textAlign: TextAlign.end, style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ),
                  ],
                ),
              ),

              // Tabla Renderizada de Movimientos
              Container(
                decoration: BoxDecoration(
                  color: HotelPMSColors.fondoTarjeta, 
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _movimientos.length,
                  separatorBuilder: (context, index) => const Divider(color: HotelPMSColors.fondoOscuro, height: 1),
                  itemBuilder: (context, index) {
                    final mov = _movimientos[index];
                    final isEgreso = mov.monto < 0;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              mov.tipo, 
                              style: TextStyle(
                                color: isEgreso ? Colors.red.shade300 : HotelPMSColors.textoPrincipal, 
                                fontWeight: FontWeight.w500, 
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mov.descripcion, style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 13)),
                                const SizedBox(height: 2),
                                Text('${mov.fecha}  ${mov.hora}', style: const TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11)),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '${isEgreso ? "-" : "+"} S/ ${mov.monto.abs().toStringAsFixed(2)}',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: isEgreso ? Colors.red.shade400 : HotelPMSColors.textoPrincipal, 
                                fontWeight: FontWeight.bold, 
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 60), // Margen para que el FAB no tape el último registro
            ],
          ),
        ),
      ),
      
      // 5. Botón Flotante Noir para Registrar Ingresos/Egresos directos
      floatingActionButton: FloatingActionButton(
        backgroundColor: HotelPMSColors.naranjaAcento,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add, size: 28),
        onPressed: () => _mostrarRegistrarMovimientoModal(context),
      ),
    );
  }

  Widget _buildTarjetaMonto(String titulo, String valor, Color colorIcono) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: HotelPMSColors.fondoTarjeta, borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titulo, style: const TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13)),
              const SizedBox(height: 6),
              Text(valor, style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Icon(Icons.attach_money, color: colorIcono, size: 22),
        ],
      ),
    );
  }

  // --- MODAL: REGISTRAR MOVIMIENTO (image_d25f63.png) ---
  void _mostrarRegistrarMovimientoModal(BuildContext context) {
    String tipoSeleccionado = 'Ingreso';
    final TextEditingController descController = TextEditingController();
    final TextEditingController montoController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16, right: 16, top: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Registrar Movimiento', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal)),
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Ingreso')),
                          selected: tipoSeleccionado == 'Ingreso',
                          selectedColor: const Color(0xFF1E3A8A), 
                          labelStyle: TextStyle(color: tipoSeleccionado == 'Ingreso' ? Colors.white : HotelPMSColors.textoSecundario),
                          onSelected: (bool selected) {
                            if (selected) setModalState(() => tipoSeleccionado = 'Ingreso');
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ChoiceChip(
                          label: const Center(child: Text('Egreso')),
                          selected: tipoSeleccionado == 'Egreso',
                          selectedColor: const Color(0xFF7F1D1D), 
                          labelStyle: TextStyle(color: tipoSeleccionado == 'Egreso' ? Colors.white : HotelPMSColors.textoSecundario),
                          onSelected: (bool selected) {
                            if (selected) setModalState(() => tipoSeleccionado = 'Egreso');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: montoController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: HotelPMSColors.textoPrincipal),
                    decoration: InputDecoration(
                      labelText: 'Monto (S/)',
                      labelStyle: const TextStyle(color: HotelPMSColors.textoSecundario),
                      filled: true,
                      fillColor: HotelPMSColors.fondoOscuro,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: descController,
                    style: const TextStyle(color: HotelPMSColors.textoPrincipal),
                    decoration: InputDecoration(
                      labelText: 'Descripción / Concepto',
                      labelStyle: const TextStyle(color: HotelPMSColors.textoSecundario),
                      filled: true,
                      fillColor: HotelPMSColors.fondoOscuro,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: HotelPMSColors.naranjaAcento),
                      onPressed: () {
                        if (montoController.text.isNotEmpty && descController.text.isNotEmpty) {
                          double monto = double.tryParse(montoController.text) ?? 0.0;
                          
                          setState(() {
                            _movimientos.insert(0, ModeloMovimiento(
                              id: DateTime.now().toString(),
                              tipo: tipoSeleccionado,
                              descripcion: descController.text,
                              fecha: '2026-06-01', 
                              hora: '16:30',
                              monto: tipoSeleccionado == 'Egreso' ? -monto : monto,
                            ));
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Guardar Transacción', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- MODAL: ARQUEO DE CAJA CORREGIDO (image_d25f3e.png) ---
  void _mostrarArqueoModal(BuildContext context) {
    final List<Map<String, dynamic>> denominaciones = [
      {'valor': 200.0, 'tipo': 'Billete'},
      {'valor': 100.0, 'tipo': 'Billete'},
      {'valor': 50.0, 'tipo': 'Billete'},
      {'valor': 20.0, 'tipo': 'Billete'},
      {'valor': 10.0, 'tipo': 'Billete'},
      {'valor': 5.0, 'tipo': 'Moneda'},
      {'valor': 2.0, 'tipo': 'Moneda'},
      {'valor': 1.0, 'tipo': 'Moneda'},
      {'valor': 0.50, 'tipo': 'Moneda'},
      {'valor': 0.20, 'tipo': 'Moneda'},
      {'valor': 0.10, 'tipo': 'Moneda'},
    ];

    // Mantenemos la persistencia de los valores temporales dentro del modal
    Map<double, int> cantidades = {for (var d in denominaciones) d['valor']: 0};

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            double totalContado = cantidades.entries.fold(0.0, (sum, entry) => sum + (entry.key * entry.value));
            double diferencia = totalContado - _saldoSistema;

            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Arqueo de Caja', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal)),
                  const Text('Ingrese la cantidad de billetes y monedas', style: TextStyle(fontSize: 12, color: HotelPMSColors.textoSecundario)),
                  const Divider(color: HotelPMSColors.fondoOscuro, height: 20),
                  
                  Expanded(
                    child: ListView.builder(
                      itemCount: denominaciones.length,
                      itemBuilder: (context, index) {
                        double val = denominaciones[index]['valor'];
                        String tipo = denominaciones[index]['tipo'];
                        int cant = cantidades[val] ?? 0;

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('S/ ${val.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold, fontSize: 14)),
                                  Text(tipo, style: const TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 11)),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove, color: HotelPMSColors.textoSecundario),
                                    onPressed: cant > 0 ? () => setModalState(() => cantidades[val] = cant - 1) : null,
                                  ),
                                  Container(
                                    width: 45,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(color: HotelPMSColors.fondoOscuro, borderRadius: BorderRadius.circular(4)),
                                    child: Text('$cant', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold)),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: HotelPMSColors.naranjaAcento),
                                    onPressed: () => setModalState(() => cantidades[val] = cant + 1),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: HotelPMSColors.fondoOscuro,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Contado:', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13)),
                            Text('S/ ${totalContado.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Saldo Sistema:', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13)),
                            Text('S/ ${_saldoSistema.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.textoPrincipal)),
                          ],
                        ),
                        const Divider(color: HotelPMSColors.fondoTarjeta),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Diferencia:', style: TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold, fontSize: 14)),
                            Text(
                              'S/ ${diferencia.toStringAsFixed(2)}',
                              style: TextStyle(color: diferencia == 0 ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: HotelPMSColors.fondoOscuro)),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar', style: TextStyle(color: HotelPMSColors.textoSecundario)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: HotelPMSColors.naranjaAcento),
                          onPressed: () {
                            setState(() {
                              _totalContadoArqueo = totalContado;
                              _arqueoRealizado = true; // CORREGIDO: Match con el estado global
                            });
                            Navigator.pop(context);
                          },
                          child: const Text('Guardar Arqueo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  // --- VISTA ADICIONAL NUEVA: MODAL DE CERRAR CAJA ---
  void _mostrarCerrarCajaModal(BuildContext context) {
    if (!_arqueoRealizado) { // CORREGIDO: Match con el estado global
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, realice el Arqueo de Caja antes de proceder al cierre.'),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }

    double diferencia = _totalContadoArqueo - _saldoSistema;
    final TextEditingController notaController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, 
            left: 16, right: 16, top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Confirmar Cierre de Caja', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal)),
                  IconButton(icon: const Icon(Icons.close, color: HotelPMSColors.textoPrincipal), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Text('Verifique los balances finales del turno actual.', style: TextStyle(fontSize: 12, color: HotelPMSColors.textoSecundario)),
              const Divider(color: HotelPMSColors.fondoOscuro, height: 20),

              _buildFilaResumenCierre('Saldo en Sistema:', 'S/ ${_saldoSistema.toStringAsFixed(2)}', HotelPMSColors.textoPrincipal),
              const SizedBox(height: 8),
              _buildFilaResumenCierre('Dinero Real Físico:', 'S/ ${_totalContadoArqueo.toStringAsFixed(2)}', HotelPMSColors.naranjaAcento),
              const SizedBox(height: 8),
              _buildFilaResumenCierre(
                'Desfase / Estado:',
                diferencia == 0 ? 'Caja Cuadrada' : 'S/ ${diferencia.toStringAsFixed(2)}',
                diferencia == 0 ? Colors.green : Colors.red,
                bold: true,
              ),
              const SizedBox(height: 16),

              const Text('Notas u Observaciones de Cierre:', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13)),
              const SizedBox(height: 6),
              TextField(
                controller: notaController,
                maxLines: 2,
                style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Ej. Faltó cuadrar céntimos por redondeo...',
                  hintStyle: const TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 13),
                  filled: true,
                  fillColor: HotelPMSColors.fondoOscuro,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444), 
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Caja cerrada con éxito. Turno finalizado.'), backgroundColor: Colors.green),
                    );
                  },
                  child: const Text('Confirmar y Cerrar Turno', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilaResumenCierre(String titulo, String valor, Color colorValor, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titulo, style: const TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 14)),
        Text(valor, style: TextStyle(color: colorValor, fontSize: 15, fontWeight: bold ? FontWeight.bold : FontWeight.w600)),
      ],
    );
  }
}