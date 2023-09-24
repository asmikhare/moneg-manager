import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomSheetForImagePicking {
  static XFile? imagePath;
  static ImagePicker picker = ImagePicker();
  static bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.image),
                onTap: () async {
                  imagePath = await picker.pickImage(
                      source: ImageSource.gallery, imageQuality: 100);
                },
                title: const Text("Select Image"),
              )
            ],
          );
        });
  }
}
