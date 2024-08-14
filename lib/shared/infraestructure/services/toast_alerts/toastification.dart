import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastificationService {
  final toastification = Toastification();

  showSuccessToast(
      {String? message,
      String? title,
      required ToastificationType typeOfToast}) {
    toastification.show(
      type: typeOfToast,
      style: ToastificationStyle.flatColored,
      title: Text(title ?? "Exito"),
      description: Text(message ?? "Accion exitosa"),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      boxShadow: lowModeShadow,
      dragToClose: true,
    );
  }
}


// 
// ToastificationType.success