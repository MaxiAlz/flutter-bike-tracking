import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationService {
  final toastification = Toastification();

  void showSuccesToast({
    String? message,
    String? title,
    ToastificationStyle? style,
    int? autoCloseDuration,
  }) {
    toastification.show(
      type: ToastificationType.success,
      style: style ?? ToastificationStyle.flatColored,
      title: Text(title ?? "Exito"),
      description: Text(message ?? "Accion exitosa"),
      alignment: Alignment.topCenter,
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }

  void showErrorToast({
    String? message,
    String? title,
    ToastificationStyle? style,
    int? autoCloseDuration,
  }) {
    toastification.show(
      type: ToastificationType.error,
      style: style ?? ToastificationStyle.flatColored,
      autoCloseDuration: Duration(seconds: autoCloseDuration ?? 6),
      title: Text(title ?? "Error"),
      description: Text(message ?? "Pruebe mas tarde"),
      alignment: Alignment.topCenter,
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }

  void showInfoToast({
    String? message,
    String? title,
    ToastificationStyle? style,
    int? autoCloseDuration,
  }) {
    toastification.show(
      type: ToastificationType.info,
      style: style ?? ToastificationStyle.flatColored,
      autoCloseDuration: Duration(seconds: autoCloseDuration ?? 6),
      title: Text(title ?? "Info"),
      description: Text(message ?? "Presta atencion a esta alerta"),
      alignment: Alignment.topCenter,
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }
}


// 
// ToastificationType.success