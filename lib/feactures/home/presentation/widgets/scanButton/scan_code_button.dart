import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/domain/auth_domain.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/home/infraestructure/errors/error_messages.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanCodeButton extends ConsumerWidget {
  const ScanCodeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(authProvider).user;
    final messages = ErrorMessages();
    handleOnPress() {
      _showDialog(
          alerDilaog: CustomDialog(),
          context: context,
          messages: messages,
          ref: ref,
          userDataAuthenticated: userData);
          
      if (userData!.documentStatus == 'APROBADO') {
        ref.read(goRouterProvider).push('/scan-qr-new-trip');
      }
    }

    // final colors = Theme.of(context).colorScheme;
    return CustomCenterFloatingActionButton(
        widthButton: 70,
        sizeIcon: 35,
        icon: Icons.qr_code_scanner_outlined,
        onPressed: handleOnPress);
  }
}

void _showDialog(
    {User? userDataAuthenticated,
    required CustomDialog alerDilaog,
    required BuildContext context,
    required WidgetRef ref,
    required ErrorMessages messages}) {
  if (userDataAuthenticated!.documentStatus != 'APROBADO') {
    alerDilaog.showUnderageDialog(
        context: context,
        ref: ref,
        icondata: Icons.info_outline,
        title: messages
            .documentAlertMessages(userDataAuthenticated.documentStatus)
            .title,
        dialogContent: Text(messages
            .documentAlertMessages(userDataAuthenticated.documentStatus)
            .detail));
  }
}

// libreria : https://pub.dev/packages/qr_code_scanner