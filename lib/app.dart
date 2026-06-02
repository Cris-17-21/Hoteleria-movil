import 'package:flutter/material.dart';
import 'package:hoteleria_erp/modulos/caja/paginas/pagina_caja.dart';
import 'package:hoteleria_erp/modulos/ventas/paginas/pagina_pos.dart';
import 'general/tema/tema_app.dart';
import 'modulos/inicio/paginas/almacen/almacen.dart';
import 'modulos/inicio/paginas/compras/compras.dart';
import 'modulos/inicio/paginas/compras/productos.dart';
import 'modulos/inicio/paginas/compras/proveedores.dart';
import 'modulos/inicio/paginas/pagina_inicio.dart';
import 'modulos/mantenimiento/paginas/pagina_mantenimiento.dart';
import 'modulos/reportes/paginas/pagina_reportes.dart';
import 'rutas/nombres_rutas.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HotelPMS',
      debugShowCheckedModeBanner: false,
      theme: HotelPMSAppTheme.darkTheme,

      initialRoute: NombresRutas.dashboard, // Constante aquí

      routes: {
        NombresRutas.dashboard: (context) =>
            const PaginaInicio(), // Constante aquí
        NombresRutas.comprasLista: (context) => const ComprasPage(),
        NombresRutas.pos: (context) => const PaginaPOS(),
        NombresRutas.caja: (context) => const PaginaCaja(),
        NombresRutas.productos: (context) => const ProductosPage(),
        NombresRutas.proveedores: (context) => const ProveedoresPage(),
        NombresRutas.almacen: (context) => const AlmacenPage(),
        NombresRutas.mantenimiento: (context) => const PaginaMantenimiento(),
        NombresRutas.reportes: (context) => const PaginaReportes(),
        // A medida que crees las páginas las vas agregando usando NombresRutas.tuRuta
      },
    );
  }
}
