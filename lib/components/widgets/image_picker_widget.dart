import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final Function(ImageSource) onPickImage;

  const ImagePickerWidget({super.key, required this.onPickImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => onPickImage(ImageSource.camera),
          icon: const Icon(Icons.camera_alt),
          label: const Text('Câmera'),
        ),
        ElevatedButton.icon(
          onPressed: () => onPickImage(ImageSource.gallery),
          icon: const Icon(Icons.photo_album),
          label: const Text('Galeria'),
        ),
      ],
    );
  }
}
