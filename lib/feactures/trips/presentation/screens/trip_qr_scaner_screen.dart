import 'dart:async';
import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/auth/presentation/providers/auth_provider.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/locker_form_provider.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  QrScannerWidgetState createState() => QrScannerWidgetState();
}

class QrScannerWidgetState extends ConsumerState<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  StreamSubscription? _scanSubscription;

  bool? isFlashOn;
  CameraFacing? cameraFacing;

  @override
  void initState() {
    super.initState();
    _initializeCameraState();
  }

  Future<void> _initializeCameraState() async {
    if (controller != null) {
      isFlashOn = await controller!.getFlashStatus();
      cameraFacing = await controller!.getCameraInfo();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;
    final userId = ref.watch(authProvider).user?.userId;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: colors.primary,
        title: Text(
          'Inicia tu viaje',
          style: subtitlesStyle!.copyWith(fontSize: 18, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(flex: 4, child: _buildQrView(context, userId)),
          Container(
            alignment: Alignment.center,
            color: colors.background,
            // flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (result != null)
                    Text('Data: ${result!.code}')
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            'Escanea el codigo en la bicicleta',
                            style: subtitlesStyle,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.pedal_bike_sharp,
                            color: colors.primary,
                          )
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            isFlashOn = await controller?.getFlashStatus();
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 5),
                              isFlashOn == true
                                  ? const Icon(Icons.flash_off)
                                  : const Icon(Icons.flash_on),
                              const Text('Flash'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            cameraFacing = await controller?.getCameraInfo();
                            setState(() {});
                          },
                          child: const Column(
                            children: [
                              SizedBox(height: 5),
                              Icon(Icons.flip_camera_ios_outlined),
                              Text('Camara'),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            controller?.dispose();
                            ref.read(goRouterProvider).go('/trip-trackin');
                          },
                          child: const Column(
                            children: [
                              SizedBox(height: 5),
                              Icon(Icons.edit_outlined),
                              Text('Escribir'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomOutlineButtom(
                      text: 'Cancelar', onPressed: _cancelAndGoHome),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _cancelAndGoHome() {
    controller?.dispose();
    if (mounted) {
      ref.read(goRouterProvider).go('/');
    }
  }

  Widget _buildQrView(BuildContext context, userId) {
    final colors = Theme.of(context).colorScheme;
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) =>
          _onQRViewCreated(context, controller, userId),
      overlay: QrScannerOverlayShape(
          borderColor: colors.primary,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 15,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(
      BuildContext context, QRViewController controller, int userId) {
    setState(() {
      this.controller = controller;
    });

    _scanSubscription = controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      if (scanData.code != null) {
        ref.read(qrFormProvider.notifier).setTrackerIdValue(scanData.code);
        ref.read(goRouterProvider).go('/trip-trackin');
        controller.dispose();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    _scanSubscription?.cancel();
    controller?.dispose();
    super.dispose();
  }
}
