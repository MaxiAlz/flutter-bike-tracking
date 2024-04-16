// import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// enum LoadingStatus { loading, notLoading }

// class LoadingProvider extends ChangeNotifier {
//   LoadingStatus _loadingStatus = LoadingStatus.notLoading;

//   LoadingStatus get loadingStatus => _loadingStatus;

//   void setLoadingStatus(LoadingStatus status) {
//     _loadingStatus = status;
//     notifyListeners();
//   }

//   void changeStatusToLoading(LoadingStatus status) {
//     _loadingStatus = LoadingStatus.loading;
//     notifyListeners();
//   }

//   void changeStatusToNotLoading(LoadingStatus status) {
//     _loadingStatus = LoadingStatus.notLoading;
//     notifyListeners();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';

final isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});
