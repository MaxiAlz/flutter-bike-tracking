import 'dart:developer';
import 'package:app_ciudadano_vc/config/config.dart';
import 'package:app_ciudadano_vc/feactures/trips/presentation/providers/locker_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

final qrStateProvider = StateProvider<String?>((ref) => "");

class QRScannerScreen extends ConsumerStatefulWidget {
  const QRScannerScreen({Key? key}) : super(key: key);

  @override
  QrScannerWidgetState createState() => QrScannerWidgetState();
}

class QrScannerWidgetState extends ConsumerState<QRScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final subtitlesStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // Color blanco para el icono de retroceso
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
          Expanded(flex: 4, child: _buildQrView(context)),
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
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    snapshot.data as bool
                                        ? const Icon(Icons.flash_off)
                                        : const Icon(Icons.flash_on),
                                    const Text('Flash'),
                                  ],
                                );
                              } else {
                                return const Text('loading');
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          child: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return const Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Icon(Icons.flip_camera_ios_outlined),
                                    Text('Camara'),
                                  ],
                                );
                              } else {
                                return const Text('loading');
                              }
                            },
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: FilledButton(
                          onPressed: () async {
                            ref
                                .read(goRouterProvider)
                                .push('/enter-bike-patent');
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // final StateProvider<String?> qrStateProvider;

    final colors = Theme.of(context).colorScheme;
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
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
    BuildContext context,
    QRViewController controller,
  ) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });

      if (scanData.code != null) {
        ref.read(qrFormProvider.notifier).setLockerValue(scanData.code);
        context.push('/test');
        controller.dispose();
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
