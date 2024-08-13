import 'package:flutter_riverpod/flutter_riverpod.dart';

final qrFormProvider =
    StateNotifierProvider<QrFormNotifier, QrFormState>((ref) {
  return QrFormNotifier();
});

class QrFormState {
  final String trackerIdValue;

  QrFormState({this.trackerIdValue = ""});

  QrFormState copyWith({
    String? trackerIdValue,
  }) {
    return QrFormState(
      trackerIdValue: trackerIdValue ?? this.trackerIdValue,
    );
  }
}

class QrFormNotifier extends StateNotifier<QrFormState> {
  QrFormNotifier() : super(QrFormState());

  void setTrackerIdValue(String? trackerIdValue) {
    state = state.copyWith(trackerIdValue: trackerIdValue);
  }
}
