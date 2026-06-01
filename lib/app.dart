import 'package:flutter/material.dart';
import 'package:hoteleria_erp/modulos/ventas/paginas/pagina_pos.dart';
import 'rutas/nombres_rutas.dart';
import 'general/tema/tema_app.dart';
import 'modulos/inicio/paginas/pagina_inicio.dart';

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
        NombresRutas.dashboard: (context) => const PaginaInicio(), // Constante aquí
        NombresRutas.pos: (context) => const PaginaPOS(),
        // A medida que crees las páginas las vas agregando usando NombresRutas.tuRuta
      },
    );
  }
}