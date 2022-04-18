import 'package:image_picker/image_picker.dart';

class ImageSelector {
  final ImagePicker _picker = ImagePicker();

  Future<String> getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    checkImageSize(await image!.length());
    return image.path;
  }
  Future<String> getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    checkImageSize(await image!.length());
    return image.path;
  }
  void checkImageSize(int imgSizeInBytes) {
    if(imgSizeInBytes > 350000) {
      throw ImageTooLargeException('image size too large!');
    }
  }
}

class ImageTooLargeException implements Exception {
  final String message;

  ImageTooLargeException(this.message);

  @override
  String toString() => message;
}