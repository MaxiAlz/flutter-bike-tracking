import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrFormProvider =
    StateNotifierProvider<QrFormNotifier, QrFormState>((ref) {
  return QrFormNotifier();
});

class QrFormState {
  final String qrValue;

  QrFormState({this.qrValue = ""});

  QrFormState copyWith({
    String? qrValue,
  }) {
    return QrFormState(
      qrValue: qrValue ?? this.qrValue,
    );
  }
}

class QrFormNotifier extends StateNotifier<QrFormState> {
  QrFormNotifier() : super(QrFormState());

  void setQrValue(String? qrValue) {
    state = state.copyWith(qrValue: qrValue);
  }
}
