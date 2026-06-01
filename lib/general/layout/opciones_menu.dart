import 'package:flutter/material.dart';
import 'modelo_opciones_menu.dart';
import '../../rutas/nombres_rutas.dart'; // Asegúrate de importar tu clase

const List<ModeloOpcionesMenu> opcionesDelMenu = [
  ModeloOpcionesMenu(
    icono: Icons.home_outlined,
    titulo: 'Dashboard',
    ruta: NombresRutas.dashboard, // Usando la constante
  ),
  ModeloOpcionesMenu(
    icono: Icons.security,
    titulo: 'Seguridad',
    subOpciones: [
      ModeloOpcionesMenu(icono: Icons.person_outline, titulo: 'Usuarios', ruta: NombresRutas.usuarios),
      ModeloOpcionesMenu(icono: Icons.shield_outlined, titulo: 'Roles', ruta: NombresRutas.roles),
    ],
  ),
  ModeloOpcionesMenu(
    icono: Icons.business,
    titulo: 'Recepción',
    subOpciones: [
      ModeloOpcionesMenu(icono: Icons.single_bed_outlined, titulo: 'Habitaciones', ruta: NombresRutas.habitaciones),
      ModeloOpcionesMenu(icono: Icons.calendar_today_outlined, titulo: 'Reservas', ruta: NombresRutas.reservas),
      ModeloOpcionesMenu(icono: Icons.assignment_turned_in, titulo: 'Check-in/Check-out', ruta: NombresRutas.checkInOut),
    ],
  ),
  ModeloOpcionesMenu(
    icono: Icons.shopping_cart,
    titulo: 'Ventas',
    subOpciones: [
      ModeloOpcionesMenu(icono: Icons.shopping_cart, titulo: 'Punto de venta', ruta: NombresRutas.pos),
    ],
  ),
  ModeloOpcionesMenu(
    icono: Icons.payments,
    titulo: 'Caja',
    ruta: NombresRutas.caja,
  ),
  // ... aplica lo mismo para las demás opciones
];