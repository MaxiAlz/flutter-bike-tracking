import 'package:app_ciudadano_vc/shared/infraestructure/services/camera_gallery/camera_gallery_service_impl.dart';
import 'package:app_ciudadano_vc/shared/widgets/buttons/custom_filled_button.dart';
import 'package:flutter/material.dart';

class UploadFiles extends StatelessWidget {
  const UploadFiles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Tóma algunas fotos',
            textAlign: TextAlign.center,
            style: titleStyle,
          ),
          Text(
            '¡Ultimo paso!',
            style: subtitleStyle,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomFilledButtom(
            text: 'Foto frente DNI',
            onPressed: () async {
              final photoPaht = await CameraGalleryServiceImpl().takePhoto();
              if (photoPaht == null) return;
              photoPaht;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          CustomFilledButtom(
            text: 'Foto dorzo DNI',
            onPressed: () async {
              final photoPaht = await CameraGalleryServiceImpl().takePhoto();
              if (photoPaht == null) return;
              photoPaht;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          CustomFilledButtom(
            text: 'Foto de tu rostro',
            onPressed: () async {
              final photoPaht = await CameraGalleryServiceImpl().takePhoto();
              if (photoPaht == null) return;
              photoPaht;
            },
          ),
        ],
      ),
    );
  }
}



