import 'package:flutter/material.dart';

class MenuItems {
  final String title;
  final String subtittle;
  final String link;
  final IconData icon;

  const MenuItems(
      {required this.title,
      required this.subtittle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItems>[
  MenuItems(
      title: 'Mi cuenta',
      subtittle: '',
      link: '/my-account',
      icon: Icons.account_circle_outlined),
  MenuItems(
      title: 'Mis viajes',
      subtittle: 'Revisa los viajes que realizaste',
      link: '/my-trips',
      icon: Icons.pedal_bike_outlined),
  MenuItems(
      title: 'Historial de reportes',
      subtittle: 'Mis reportes ciudadanos.',
      link: '/not-found',
      icon: Icons.report_outlined),
  MenuItems(
      title: 'Terminos y condiciones',
      subtittle: '',
      link: '/not-found',
      icon: Icons.comment_bank_outlined),
  MenuItems(
      title: 'Ayuda',
      subtittle: '',
      link: '/not-found',
      icon: Icons.help_outline_outlined),
];
