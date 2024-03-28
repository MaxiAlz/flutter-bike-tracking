import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filesRegisterFormProvider = StateNotifierProvider.autoDispose<
    FilesRegisterFormNotifier, FilesRegisterState>((ref) {
  return FilesRegisterFormNotifier();
});

// Estado del formulario

class FilesRegisterState {
  final String photoUserPath;
  final String photoDniFrontPath;
  final String photoDniBackPath;
  final bool isFilesPathsCompleted;

  FilesRegisterState({
    this.isFilesPathsCompleted = false,
    this.photoUserPath = '',
    this.photoDniFrontPath = '',
    this.photoDniBackPath = '',
  });

  FilesRegisterState copyWith({
    String? photoUserPath,
    String? photoDniFrontPath,
    String? photoDniBackPath,
    bool? isFilesPathsCompleted,
  }) {
    return FilesRegisterState(
        photoUserPath: photoUserPath ?? this.photoUserPath,
        photoDniFrontPath: photoDniFrontPath ?? this.photoDniFrontPath,
        photoDniBackPath: photoDniBackPath ?? this.photoDniBackPath,
        isFilesPathsCompleted:
            isFilesPathsCompleted ?? this.isFilesPathsCompleted);
  }

  @override
  String toString() {
    return ''' 
        FilesRegisterState state:
        photoUserPath: $photoUserPath
        photoDniFrontPath: $photoDniFrontPath
        photoDniBackPath: $photoDniBackPath
        isFilesPathsCompleted: $isFilesPathsCompleted
        ''';
  }
}

class FilesRegisterFormNotifier extends StateNotifier<FilesRegisterState> {
  FilesRegisterFormNotifier() : super(FilesRegisterState());

  void printState() {
    print(state.toString());
  }

  VoidCallback? getPrintStateFunction() {
    if (state.isFilesPathsCompleted) {
      return () => printState();
    } else {
      return null;
    }
  }

  void setPhotoUserDevicePath({required String value}) {
    state = state.copyWith(photoUserPath: value);
    _setFilesPathsCompleted();
  }

  void setPhotoDniFrontDevicePath({required String value}) {
    state = state.copyWith(photoDniFrontPath: value);
    _setFilesPathsCompleted();
  }

  void setPhotoDniBackDevicePath({required String value}) {
    state = state.copyWith(photoDniBackPath: value);
    _setFilesPathsCompleted();
  }

  _setFilesPathsCompleted() {
    if (state.photoDniBackPath.isNotEmpty &&
        state.photoDniFrontPath.isNotEmpty &&
        state.photoUserPath.isNotEmpty) {
      return state = state.copyWith(isFilesPathsCompleted: true);
    } else {
      state = state.copyWith(isFilesPathsCompleted: false);
    }
  }
}
