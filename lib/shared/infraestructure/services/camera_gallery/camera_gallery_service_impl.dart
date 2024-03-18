import 'package:app_ciudadano_vc/shared/infraestructure/services/camera_gallery/camera_gallery_service.dart';
import 'package:image_picker/image_picker.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {
  final ImagePicker _picker = ImagePicker();
  @override
  Future<String?> selectPhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.gallery);

    if (photo == null) return null;

    print('Tenermos imagen =>>>>>>>> ${photo.path}');
    return photo.path;
  }

  @override
  Future<String?> takePhoto() async {
    final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

    if (photo == null) return null;

    print('Tenermos imagen =>>>>>>>> ${photo.path}');
    return photo.path;
  }
}
