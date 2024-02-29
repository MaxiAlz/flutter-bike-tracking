import 'package:app_ciudadano_vc/shared/infraestructure/services/camera_gallery_service_impl.dart';
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



// return Column(
    //   children: [
    //     TextButton.icon(
    //       onPressed: () async {
    //         final photoPah = await CameraGalleryServiceImpl().selectPhoto();
    //         if (photoPah == null) return;
    //         photoPah;
    //       },
    //       icon: Icon(Icons.browse_gallery),
    //       label: Text('galeria'),
    //     ),
    //     TextButton.icon(
    //       onPressed: () async {
    //         final photoPah = await CameraGalleryServiceImpl().takePhoto();
    //         if (photoPah == null) return;
    //         photoPah;
    //       },
    //       icon: Icon(Icons.camera),
    //       label: Text('camara'),
    //     ),
    //   ],
    // );