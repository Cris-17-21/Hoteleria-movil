import 'package:flutter/material.dart';
import 'package:hoteleria_erp/modulos/caja/paginas/pagina_caja.dart';
import 'package:hoteleria_erp/modulos/ventas/paginas/pagina_pos.dart';
import 'rutas/nombres_rutas.dart';
import 'general/tema/tema_app.dart';
import 'modulos/inicio/paginas/pagina_inicio.dart';
import 'modulos/seguridad/paginas/pagina_usuarios.dart'; // 1. Importamos tu nueva pantalla
import 'modulos/seguridad/paginas/pagina_roles.dart';
import 'modulos/recepcion/paginas/pagina_habitaciones.dart';
import 'modulos/recepcion/paginas/pagina_reservas.dart';
import 'modulos/recepcion/paginas/pagina_checkin_out.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HotelPMS',
      debugShowCheckedModeBanner: false,
      theme: HotelPMSAppTheme.darkTheme,

      initialRoute: NombresRutas.dashboard,

      routes: {
        NombresRutas.dashboard: (context) => const PaginaInicio(),
        NombresRutas.usuarios: (context) => const PaginaUsuarios(),
        NombresRutas.habitaciones: (context) => const PaginaHabitaciones(),
        NombresRutas.reservas: (context) => const PaginaReservas(),
        NombresRutas.checkInOut: (context) => const PaginaCheckInOut(),
        NombresRutas.roles: (context) =>
            const PaginaRoles(), // 2. Registramos la ruta de usuarios
        NombresRutas.dashboard: (context) =>
            const PaginaInicio(), // Constante aquí
        NombresRutas.pos: (context) => const PaginaPOS(),
        NombresRutas.caja: (context) => const PaginaCaja(),
        // A medida que crees las páginas las vas agregando usando NombresRutas.tuRuta
      },
    );
  }
}
