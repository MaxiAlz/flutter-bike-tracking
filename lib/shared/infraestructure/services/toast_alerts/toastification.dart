import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationService {
  final toastification = Toastification();

  void showSuccesToast({
    String? message,
    String? title,
  }) {
    toastification.show(
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? "Exito"),
      description: Text(message ?? "Accion exitosa"),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }

  void showErrorToast({
    String? message,
    String? title,
  }) {
    toastification.show(
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? "Error"),
      description: Text(message ?? "Ah ocurrido un error,Pruebe mas tarde"),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }

  void showInfoToast({
    String? message,
    String? title,
  }) {
    toastification.show(
      type: ToastificationType.info,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? "Info"),
      description: Text(message ?? "Presta atencion a esta alerta"),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }
}


// 
// ToastificationType.success