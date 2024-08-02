import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrFormProvider =
    StateNotifierProvider<QrFormNotifier, QrFormState>((ref) {
  return QrFormNotifier();
});

class QrFormState {
  final String lockerValue;

  QrFormState({this.lockerValue = ""});

  QrFormState copyWith({
    String? lockerValue,
  }) {
    return QrFormState(
      lockerValue: lockerValue ?? this.lockerValue,
    );
  }
}

class QrFormNotifier extends StateNotifier<QrFormState> {
  QrFormNotifier() : super(QrFormState());

  void setLockerValue(String? lockerValue) {
    state = state.copyWith(lockerValue: lockerValue);
  }
}
