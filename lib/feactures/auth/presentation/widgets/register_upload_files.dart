import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/files_register_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/register_form_provider.dart';
import 'package:app_ciudadano_vc/feactures/auth/infraestructure/service/register_service.dart';
import 'package:app_ciudadano_vc/shared/infraestructure/share_infraestructure.dart';
import 'package:app_ciudadano_vc/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

// final isLoadingProvider = StateProvider.autoDispose<bool>((ref) {
//   return false;
// });

class UploadFiles extends ConsumerWidget {
  const UploadFiles({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      body: _UploadFilesView(
          titleStyle: titleStyle, subtitleStyle: subtitleStyle),
    );
  }
}

class _UploadFilesView extends ConsumerWidget {
  final WidgetStatesController photoFacePathController =
      WidgetStatesController();
  static WidgetStatesController photonDinFrontPath = WidgetStatesController();
  final WidgetStatesController photoDniBackPath = WidgetStatesController();

  _UploadFilesView({
    required this.titleStyle,
    required this.subtitleStyle,
  });

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(registerFormProvider);
    final fileRegisterForm = ref.watch(filesRegisterFormProvider);
    final routerProvider = ref.watch(goRouterProvider);
    final isLoading = ref.watch(isLoadingProvider);
    final toastification = ToastificationService();

    final RegisterServices registerService = RegisterServices();

    final buttonStyles = ButtonStyle(
      minimumSize: WidgetStateProperty.all<Size>(const Size(300, 50)),
    );
    const textStylesButton =
        TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

    void onPressRegisterUser(context) async {
      ref.watch(isLoadingProvider.notifier).update((state) => true);

      try {
        final serviceResponse = await registerService.registerUser(
            files: fileRegisterForm, userData: registerForm);

        if (serviceResponse.statusCode == 201) {
          toastification.showSuccesToast(
              title: 'Registro Exitoso',
              message: 'Ingresa nuevamente tu numero para ingresar al sistema',
              style: ToastificationStyle.fillColored,
              autoCloseDuration: 20);
        }
      } catch (e) {
        toastification.showErrorToast(
            message: 'No se pudo registrar el usuario, pruebe mas tarde, $e');
        Exception(e);
      } finally {
        routerProvider.push('/auth');
        ref.watch(isLoadingProvider.notifier).update((state) => false);
      }
    }

    return isLoading
        ? const FullLoader()
        : SingleChildScrollView(
            child: Container(
              // color: Colors.black,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/vamos-en-bici-01.png', width: 250),
                  Column(
                    children: [
                      Text(
                        '¡Ultimo paso ${registerForm.name}!',
                        textAlign: TextAlign.center,
                        style: titleStyle,
                      ),
                      Text(
                        'Necesitaremos  algunas fotos para continuar',
                        style: subtitleStyle,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomOutlineButtom(
                        text: 'Foto de tu rostro',
                        icon: fileRegisterForm.photoUserPath.isNotEmpty
                            ? const Icon(Icons.check)
                            : null,
                        // icon: const Icon(Icons.abc),
                        statesController: photoFacePathController,
                        onPressed: () async {
                          final photoPaht =
                              await CameraGalleryServiceImpl().takePhoto();
                          if (photoPaht == null) return;
                          return ref
                              .read(filesRegisterFormProvider.notifier)
                              .setPhotoUserDevicePath(value: photoPaht);
                        },
                      ),
                      _SpacerInfo(
                          titleStyle: titleStyle,
                          subtitleStyle: subtitleStyle,
                          registerForm: registerForm),
                      CustomOutlineButtom(
                        statesController: photonDinFrontPath,
                        text: 'Foto frente DNI',
                        icon: fileRegisterForm.photoDniFrontPath.isNotEmpty
                            ? const Icon(Icons.check)
                            : null,
                        onPressed: () async {
                          final photoPaht =
                              await CameraGalleryServiceImpl().takePhoto();
                          if (photoPaht == null) return;
                          return ref
                              .read(filesRegisterFormProvider.notifier)
                              .setPhotoDniFrontDevicePath(value: photoPaht);
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomOutlineButtom(
                        statesController: photonDinFrontPath,
                        text: 'Foto dorzo DNI',
                        icon: fileRegisterForm.photoDniBackPath.isNotEmpty
                            ? const Icon(Icons.check)
                            : null,
                        onPressed: () async {
                          final photoPaht =
                              await CameraGalleryServiceImpl().takePhoto();
                          if (photoPaht == null) return;
                          ref
                              .read(filesRegisterFormProvider.notifier)
                              .setPhotoDniBackDevicePath(value: photoPaht);
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      FilledButton(
                          style: buttonStyles,
                          // onPressed: () => registerUSer(),
                          onPressed: fileRegisterForm.isFilesPathsCompleted
                              ? () => onPressRegisterUser(context)
                              : null,
                          child: const Text(
                            'Finalizar registro',
                            style: textStylesButton,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}

class _SpacerInfo extends StatelessWidget {
  const _SpacerInfo({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.registerForm,
  });

  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final RegisterFormState registerForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Ahora tu DNI',
          textAlign: TextAlign.center,
          style: titleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'Debe coincidir con el paso anterior:',
          style: subtitleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          registerForm.identificationNumber,
          style: subtitleStyle,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
