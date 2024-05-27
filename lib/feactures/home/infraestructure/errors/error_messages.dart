class PendingDocumentMsg {
  final String title;
  final String detail;

  PendingDocumentMsg({required this.title, required this.detail});
}

class ErrorMessages {
  PendingDocumentMsg documentAlertMessages(String documentStatus) {
    switch (documentStatus) {
      case 'PENDIENTE_MONITOREO':
        return PendingDocumentMsg(
            title: 'Usuario pendiente',
            detail:
                'Estamos validando tus datos, para que puedas usar el servicio. Intentalo mas tarde');
      case 'PENDIENTE_USUARIO':
        return PendingDocumentMsg(
            title: 'Actualiza tu documentacion',
            detail:
                'Por favor, actualiza tu documentación para usar este servicio');
      default:
        return PendingDocumentMsg(
            title: 'Error desconocido',
            detail:
                'Ha ocurrido un error desconocido. Por favor, inténtalo de nuevo más tarde.');
    }
  }
}
