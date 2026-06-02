import 'package:flutter/material.dart';
import '../../../general/layout/layout_principal.dart';
import '../../../general/tema/colores_tema.dart';
import '../../../rutas/nombres_rutas.dart';
import '../modelos/modelo_producto.dart';

class PaginaPOS extends StatefulWidget {
  const PaginaPOS({super.key});

  @override
  State<PaginaPOS> createState() => _PaginaPOSState();
}

class _PaginaPOSState extends State<PaginaPOS> {
  // Datos quemados basados estrictamente en image_d274e9.png
  final List<ModeloProducto> _productosMock = [
    const ModeloProducto(id: '1', nombre: 'Coca Cola 500ml', categoria: 'Bebidas', precio: 5.0, stock: 50),
    const ModeloProducto(id: '2', nombre: 'Agua Mineral', categoria: 'Bebidas', precio: 3.0, stock: 100),
    const ModeloProducto(id: '3', nombre: 'Sandwich Mixto', categoria: 'Alimentos', precio: 12.0, stock: 20),
    const ModeloProducto(id: '4', nombre: 'Pizza Personal', categoria: 'Alimentos', precio: 18.0, stock: 15),
  ];

  List<ModeloProducto> _productosFiltrados = [];
  final Map<ModeloProducto, int> _carrito = {};
  String _filtroBusqueda = '';

  @override
  void initState() {
    super.initState();
    _productosFiltrados = _productosMock;
  }

  void _filtrarProductos(String consulta) {
    setState(() {
      _filtroBusqueda = consulta;
      _productosFiltrados = _productosMock
          .where((p) => p.nombre.toLowerCase().contains(consulta.toLowerCase()))
          .toList();
    });
  }

  void _agregarAlCarrito(ModeloProducto producto) {
    setState(() {
      if (_carrito.containsKey(producto)) {
        if (_carrito[producto]! < producto.stock) {
          _carrito[producto] = _carrito[producto]! + 1;
        }
      } else {
        _carrito[producto] = 1;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${producto.nombre} agregado al carrito'),
        duration: const Duration(milliseconds: 800),
        backgroundColor: HotelPMSColors.naranjaAcento,
      ),
    );
  }

  int get _totalItemsCarrito => _carrito.values.fold(0, (sum, q) => sum + q);

  double get _subtotal {
    double total = _carrito.entries.fold(0.0, (sum, entry) => sum + (entry.key.precio * entry.value));
    return total / 1.18; // Extrayendo el IGV para el desglose del total
  }

  double get _igv => _subtotal * 0.18;

  double get _total => _carrito.entries.fold(0.0, (sum, entry) => sum + (entry.key.precio * entry.value));

  @override
  Widget build(BuildContext context) {
    return LayoutPrincipal(
      rutaActual: NombresRutas.pos,
      tituloBarra: 'HotelPMS',
      cuerpo: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fila del Título y Botón del Carrito (image_d274e9.png)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined, color: HotelPMSColors.naranjaAcento, size: 28),
                    const SizedBox(width: 8),
                    const Text(
                      'Punto de Venta',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal),
                    ),
                  ],
                ),
                // Botón Carrito con Badge de cantidad
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () => _mostrarCarritoModal(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: HotelPMSColors.naranjaAcento,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.shopping_cart, color: HotelPMSColors.textoPrincipal, size: 24),
                      ),
                    ),
                    if (_totalItemsCarrito > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.white,
                          child: Text(
                            '$_totalItemsCarrito',
                            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),

          // Buscador de productos
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: _filtrarProductos,
              style: const TextStyle(color: HotelPMSColors.textoPrincipal),
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                hintStyle: const TextStyle(color: HotelPMSColors.textoSecundario),
                prefixIcon: const Icon(Icons.search, color: HotelPMSColors.textoSecundario),
                filled: true,
                fillColor: HotelPMSColors.fondoInput,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Cuadrícula de Catálogo de Productos
          Expanded(
            child: _productosFiltrados.isEmpty
                ? const Center(
                    child: Text('No se encontraron productos', style: TextStyle(color: HotelPMSColors.textoSecundario)),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.78,
                    ),
                    itemCount: _productosFiltrados.length,
                    itemBuilder: (context, index) {
                      final producto = _productosFiltrados[index];
                      return _TarjetaProducto(
                        producto: producto,
                        onTap: () => _agregarAlCarrito(producto),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // Despliegue lateral/inferior del Carrito de compras (image_d27229.png)
  void _mostrarCarritoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: HotelPMSColors.fondoTarjeta,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Encabezado del modal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Carrito ($_totalItemsCarrito)',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: HotelPMSColors.textoPrincipal),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: HotelPMSColors.textoPrincipal),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                  const Divider(color: HotelPMSColors.fondoInput),

                  // Contenido del Carrito (Lista de productos o estado vacío)
                  Expanded(
                    child: _carrito.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.shopping_cart_outlined, size: 48, color: HotelPMSColors.fondoInput),
                                const SizedBox(height: 12),
                                const Text('Carrito vacío', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 14)),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: _carrito.length,
                            itemBuilder: (context, index) {
                              final producto = _carrito.keys.elementAt(index);
                              final cantidad = _carrito[producto]!;
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(producto.nombre, style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14)),
                                subtitle: Text('S/ ${producto.precio.toStringAsFixed(2)} x $cantidad', style: const TextStyle(color: HotelPMSColors.textoSecundario)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, color: HotelPMSColors.textoSecundario),
                                      onPressed: () {
                                        setModalState(() {
                                          setState(() {
                                            if (cantidad > 1) {
                                              _carrito[producto] = cantidad - 1;
                                            } else {
                                              _carrito.remove(producto);
                                            }
                                          });
                                        });
                                      },
                                    ),
                                    Text('$cantidad', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, color: HotelPMSColors.naranjaAcento),
                                      onPressed: () {
                                        setModalState(() {
                                          setState(() {
                                            if (cantidad < producto.stock) {
                                              _carrito[producto] = cantidad + 1;
                                            }
                                          });
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),

                  // Bloque de Totales y Formulario de Facturación
                  const Divider(color: HotelPMSColors.fondoInput, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal:', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 14)),
                      Text('S/ ${_subtotal.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('IGV (18%):', style: TextStyle(color: HotelPMSColors.textoSecundario, fontSize: 14)),
                      Text('S/ ${_igv.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total:', style: TextStyle(color: HotelPMSColors.textoPrincipal, fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('S/ ${_total.toStringAsFixed(2)}', style: const TextStyle(color: HotelPMSColors.naranjaAcento, fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Formulario: Datos del Cliente (DNI/RUC)
                  TextField(
                    style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'DNI/RUC Cliente',
                      hintStyle: const TextStyle(color: HotelPMSColors.textoSecundario),
                      filled: true,
                      fillColor: HotelPMSColors.fondoOscuro,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    style: const TextStyle(color: HotelPMSColors.textoPrincipal, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Nombre del Cliente',
                      hintStyle: const TextStyle(color: HotelPMSColors.textoSecundario),
                      filled: true,
                      fillColor: HotelPMSColors.fondoOscuro,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botón de Enviar Pago
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8C4322), // Tono marrón-naranja quemado de tu captura
                        foregroundColor: HotelPMSColors.textoPrincipal,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _carrito.isEmpty ? null : () {
                        // TODO: Lógica para transaccionar o enviar al backend/SUNAT
                        Navigator.pop(context);
                      },
                      child: const Text('Procesar Pago', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Widget Interno: Tarjeta de Producto individual
class _TarjetaProducto extends StatelessWidget {
  final ModeloProducto producto;
  final VoidCallback onTap;

  const _TarjetaProducto({required this.producto, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder del icono del producto (imagen central)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: HotelPMSColors.fondoOscuro,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.shopping_cart_outlined, color: HotelPMSColors.textoSecundario, size: 36),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                producto.nombre,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: HotelPMSColors.textoPrincipal),
              ),
              const SizedBox(height: 2),
              Text(
                producto.categoria,
                style: const TextStyle(fontSize: 11, color: HotelPMSColors.textoSecundario),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'S/ ${producto.precio.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: HotelPMSColors.naranjaAcento),
                  ),
                  Text(
                    'Stock: ${producto.stock}',
                    style: const TextStyle(fontSize: 10, color: HotelPMSColors.textoSecundario),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}